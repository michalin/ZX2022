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

#include "memory.h"
#include "debug.h"

char s_msg[255];

uint8_t memRead(uint16_t addr)
{
    uint8_t val;
    MREQ(ACTIVE);
    WR(PASSIVE);
    DDRA = 0xFF;
    PORTA = (uint8_t)addr;
    DDRC = 0xFF;
    PORTC = (uint8_t)(addr >> 8);
    DDRL = 0;
    RD(ACTIVE);
    delayMicroseconds(10);
    val = PINL;
    RD(PASSIVE);
    MREQ(PASSIVE);
    DDRA = 0;
    DDRC = 0;
    return val;
}

void memRead(uint8_t *buffer, uint16_t saddr, uint16_t len)
{
    for (uint16_t i = 0; i < len; i++)
    {
        buffer[i] = memRead(saddr + i);
    }
}

void memWrite(uint16_t addr, uint8_t data)
{
    DDRA = 0xFF;
    PORTA = (uint8_t)addr;
    DDRC = 0xFF;
    PORTC = (uint8_t)(addr >> 8);
    DDRL = 0xFF;
    PORTL = data;
    MREQ(ACTIVE);
    WR(ACTIVE);
    // delay(1);
    WR(PASSIVE);
    MREQ(PASSIVE);
    DDRA = 0;
    DDRC = 0;
    DDRL = 0;
}

bool memWrite(uint8_t *buffer, uint16_t saddr, uint16_t len)
{
    for (uint16_t i = 0; i < len; i++)
    {
        memWrite(saddr + i, buffer[i]);
        if ((i + 1) % 64 == 0)
            delay(10); // Wait a bit until page is written
    }
    delay(10); // Wait for last bytes to be written

    uint8_t buf[len];
    memRead(buf, saddr, len);
    return (memcmp(buf, buffer, len) == 0);
}

void memProtect(bool set)
{
    // memSelect(MEMORY::WRITE);
    if (set)
    {
        memWrite(0x5555, 0xaa);
        memWrite(0x2aaa, 0x55);
        memWrite(0x5555, 0xa0);
    }
    else
    { // Disable memory protection
        memWrite(0x5555, 0xaa);
        memWrite(0x2aaa, 0x55);
        memWrite(0x5555, 0x80);
        memWrite(0x5555, 0xaa);
        memWrite(0x2aaa, 0x55);
        memWrite(0x5555, 0x20);
    }
    delay(10);
    // memSelect(MEMORY::IDLE);
}

void memTest()
{
    Serial.println("Starting SRAM Test");
    delay(10);
    BUSRQ(ACTIVE);
    MREQ(ACTIVE);
    int errors = 0;
    for (int addr_hi = 255; addr_hi >= 0; addr_hi--)
    {
        for (uint16_t addr_lo = 0; addr_lo <= 0xFF; addr_lo += 1)
        {
            uint16_t addr = (addr_hi << 8) + addr_lo;
            memWrite(addr, addr_hi);
        }

        for (uint16_t addr_lo = 0; addr_lo <= 0xFF; addr_lo += 1)
        {
            uint16_t addr = (addr_hi << 8) + addr_lo;
            uint8_t rdback = memRead(addr);
            if (rdback != addr_hi)
            {
                sprintf(s_msg, "Error at 0x%04X: Readback is 0x%02X, should be 0x%02X", addr, rdback, addr_lo);
                Serial.println(s_msg);
                errors++;
            }
            memWrite(addr, 0);
        }
    }
    sprintf(s_msg, "\nSRAM test passed with %d errors", errors);
    Serial.println(s_msg);
    BUSRQ(PASSIVE);
}
