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

#ifndef Z80_H
#define Z80_H

#include <Arduino.h>
// Port B
#define RTSB_PIN PB0 //(Arduino Pin 53) 
#define RTSA_PIN PB1 //(Arduino Pin 52) 
#define MREQ_PIN PB2 //(Arduino Pin 51) Z80 Pin 19
#define RST_PIN PB3 //(Arduino Pin 50) Z80 PIN 26
// Port G
#define RD_PIN PG0   //(Arduino Pin 41) Z80 Pin 21
#define WR_PIN PG1   //(Arduino Pin 40) Z80 Pin 22
#define BUSACK_PIN PG2 //(Arduino Pin 39) Z80 Pin 23
// Port D
#define BUSRQ_PIN PD7  //(Artduino Pin 38) Z80 Pin 25
// Port E
#define TX0_PIN PE0 //(Arduino Pin0 / RX0)
#define TX1_PIN PE1 //(Arduino Pin1 / TX1)
// Address bus
#define ADDR_LO PINA // A0..A7
#define ADDR_HI PINC // A8..A9
#define ADDR ((ADDR_HI << 8) + ADDR_LO)

#define ACTIVE 1  // 0V
#define PASSIVE 0 // 5V, pulled up by 10k resistor

#define BUSERROR 0 //BUSACK failed

inline void RD(uint8_t b)
{
  (b == ACTIVE) ? bitClear(PORTG, RD_PIN) : bitSet(PORTG, RD_PIN);
}
inline void WR(uint8_t b)
{
  (b == ACTIVE) ? bitClear(PORTG, WR_PIN) : bitSet(PORTG, WR_PIN);
}

inline void MREQ(uint8_t b)
{
  (b == ACTIVE) ? bitClear(PORTB, MREQ_PIN) : bitSet(PORTB, MREQ_PIN);
}

inline void BUSALLOC(bool b)
{
  if (b) // Allocate bus
  {
    DDRA = 0xFF; //Addr LO
    DDRC = 0xFF; //Addr HI
    DDRL = 0xFF; //Data
    DDRB |= (1 << MREQ_PIN);
    PORTB |= (1 << MREQ_PIN); //All high (passive)
    DDRG |= (1 << RD_PIN) + (1 << WR_PIN);
    PORTG |= (1 << RD_PIN) + (1 << WR_PIN);
  }
  else // Free bus
  {
    DDRA = 0;
    DDRC = 0;
    DDRL = 0;
    DDRB &= ~((1 << MREQ_PIN) + (1 << RTSA_PIN) + (1 << RTSB_PIN));
    DDRG &= ~((1 << RD_PIN) + (1 << WR_PIN));
  }
}

inline bool BUSRQ(bool b)
{
  b ? bitSet(DDRD, BUSRQ_PIN) : bitClear(DDRD, BUSRQ_PIN);

  //Has Z80 ack'ed the request?
  delay(100);
  if (bitRead(PING, BUSACK_PIN) == b)
  {
    bitClear(DDRD, BUSRQ_PIN); 
    return BUSERROR;
  }

  BUSALLOC(b);
  return 1;
}

inline void RESET(bool b)
{
  b == ACTIVE ? bitSet(DDRB, RST_PIN) : bitClear(DDRB, RST_PIN);
}

inline void RESET()
{
  RESET(ACTIVE);
  delay(100);
  RESET(PASSIVE);
}

#endif