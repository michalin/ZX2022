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

#ifndef SRAM_H
#define SRAM_H

#include <Arduino.h>
#include "Z80.h"

//#define MEMTEST //Unselect ONLY if DART chip is not present. Will lead to malfunction and might even KILL the DART.

#define BANK0 0
#define BANK1 1
#define BANK2 2
#define EEPROM 3

/**
 * @brief Read single value from memory
 * @param addr: Memory address of value 
 * @return uint8_t value
 */

uint8_t memRead(uint16_t addr);
/**
 * @brief Read multible bytes from memory
 * 
 * @param buffer: Pointer to a buffer
 * @param addr: Address of first byte to read
 * @param length: Number of bytes to read
 */
void memRead(uint8_t* buffer, uint16_t addr, uint16_t length);

/**
 * @brief Write a byte to memory
 * 
 * @param addr 
 * @param value 
 */
void memWrite(uint16_t addr, uint8_t value);

/**
 * @brief Write a buffer to memory
 * 
 * @param buffer: Pointer to the buffer to be written 
 * @param addr: Start address in Memory
 * @param len: Number of bytes
 * @returns true on success
 */
bool memWrite(uint8_t* buffer, uint16_t addr, uint16_t length);

/**
 * @brief Set software write protection of EEPROM
 * @param set true: Set protection, false: Release protection
 */
void memProtect(bool set);


#endif