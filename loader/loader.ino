/* Copyright (C) 2020  Doctor Volt

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
//#include "serdisk.h"
#include "Z80.h"
#include "memory.h"
#include "debug.h"

#define CHUNKLEN 32
#define RTSA 52
#define RTSB 53
#define FS_BASE 0x4000

struct Direntry // https://www.seasip.info/Cpm/format31.html
{
  uint8_t usernum = 0;                                               // User number. 0-15
  char filename[8];                                                  // = {32, 32, 32, 32, 32, 32, 32, 32};               // File name
  char fileext[3];                                                   // = {32, 32, 32};                                    // File extension
  uint8_t EX = 0;                                                    // Extent number, Low byte
  uint8_t S2 = 0;                                                    // Extent number, High byte
  uint8_t S1 = 0;                                                    // Last Record Byte count
  uint8_t RC = 0;                                                    // Number of records (1 record=128 bytes)
  uint8_t AL[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; // Allocation. Each AL is the number of a block on the disc
};
Direntry entry;

// Parameter structure for the @ldcpm command
struct Ldaddr
{
  uint16_t base; // Memory address where the image starts
  uint16_t size; // Size of the image
  uint8_t reserved;
  char fname[8];
  char fext[3];
} ldaddr;

void setup()
{
  bus_idle();
  Serial.begin(115200);
  println("Arduino restarted");
  // Check if there is a response on busrequest if not: ZX2020 not connected
  bool connected = true;
  if (BUSRQ(ACTIVE) == BUSERROR)
  {
    connected = false;
  }
  if (BUSRQ(PASSIVE) == BUSERROR)
  {
    connected = false;
  }
  if (!connected)
  {
    println("Not connected to ZX 2020 bus");
    Serial.write("<$>started</$>");
    //delay(10);
    Serial.end();
    return;
  }
  println("ZX 2020 bus connected");
  Serial.write("<$>ready</$>");
}

void serialEvent()
{
  static uint16_t bytestoload = 0;
  static uint16_t addr; // start addr = BDOS address
  uint8_t chunk[CHUNKLEN];

  Serial.readBytes(chunk, CHUNKLEN);        // Read chunk
  if (bytestoload == 0)                     // Is it a command from PC? (@...@)
  {                                         // Handle commands
    String command = String((char *)chunk); // Serial.readString();
    //println(command.c_str());
    command = command.substring(command.indexOf("@") + 1, command.indexOf("@", 2)); // .lastIndexOf("@"));
    if (command.equals("load"))
    {
      //  Get start address and total number of bytes expected
      memcpy(&ldaddr, (chunk + 6), sizeof(ldaddr));
      bytestoload = ldaddr.size;
      addr = ldaddr.base;
      RESET();
      if (BUSRQ(ACTIVE) == BUSERROR)
      {
        println("Loader Error: BUS request failed");
        return;
      }
      if (digitalRead(RTSA) && digitalRead(RTSB))
        println("EEPROM selected");
      else
        println("Warning: Could not select EEPROM. Writing to RAM");

      memProtect(false);
      println("Loading %d bytes (%d chunks). Base: 0x%04X", bytestoload, bytestoload / CHUNKLEN, addr);
      Serial.write("<$>rqchunk</$>"); // Signal for loader to send first chunk of image file
      return;
    }
    else if (command.startsWith("start"))
    {
      println("ZX2022 %s",
              command.substring(command.indexOf(":") + 1, command.length()).c_str());
      Serial.write("<$>started</$>");
      RESET();
      bus_idle();
      Serial.end(); // Now the ZX2020 can use the UART0 interface for the serial disk
    }
    else if (command.equals("mkdsk"))
    {
      RESET();
      if (BUSRQ(ACTIVE) == BUSERROR)
      {
        println("Loader Error: BUS request failed");
        return;
      }

      memProtect(false);
      uint8_t *rec_buf = (uint8_t*) malloc(1024);
      memset(rec_buf, 0xE5, 1024);
      memWrite(rec_buf, FS_BASE, 1024);

      if (ldaddr.size) // There is a file: Write record
      {
        String fname = String(ldaddr.fname).substring(0, 8);
        fname.trim();
        println("Writing directory record for file: %s.%s", fname.c_str(), ldaddr.fext);
        memcpy(entry.filename, ldaddr.fname, 8);
        memcpy(entry.fileext, ldaddr.fext, 3);
        entry.RC = ldaddr.size / 128;
        for (int i = 0; i <= ldaddr.size / 1024; i++)
          entry.AL[i] = i + 1;
        if(!memWrite((uint8_t*)&entry, FS_BASE, 32))
        {
          println("Memory Write Error");
        }
        //hexdump((uint8_t*)&entry,0,32);
      }
      Serial.write("<$>ready</$>");
      memProtect(true);
      println("EE Prom disk written");
    }
    else if (command.startsWith("serdsk"))
    {
      //println("Serial disk ready");
      bus_idle();
      Serial.end();
    }
  }
  else if (bytestoload > 0) // Is there still data to load into EEPROM?
  {
    if (!memWrite(chunk, addr, CHUNKLEN))
    {
      println("Memory Write Error");
      bytestoload = 0;
      return;
      Serial.write("<$>error</$>");
    }
    addr += CHUNKLEN;
    bytestoload -= CHUNKLEN;

    Serial.write("<$>rqchunk</$>"); // Request next chunk
    // println("%d bytes left", bytestoload);
    if (bytestoload == 0) // All chunks processed
    {
      println("Success");
      memProtect(true);
      Serial.write("<$>ready</$>");
      return;
    }
  }
}

void bus_idle()
{
  DDRA = 0; // Addr Low
  PORTA = 0;
  DDRB = 0; // RTSA, RTSB, RST, MREQ
  PORTB = 0;
  DDRC = 0; // Addr Hi
  PORTC = 0;
  DDRD = 0; // BUSRQ
  PORTD = 0;
  DDRE = 0; // RX0, TX0
  PORTE = 0;
  DDRG = 0; // RD, WR, BUSACK
  PORTG = 0;
  DDRL = 0; // DATA
  PORTL = 0;
}

void loop()
{
}
