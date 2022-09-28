/*Arduino Library for CF Cards and PATA hard disks
Copyright (C) 2020  Michael Linsenmeier (michalin70@gmail.com)
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.*/

#ifndef DEBUG_H
#define DEBUG_H
#include <Arduino.h>

/** 
 * @brief output sprintf formatted string on loader app
*/
void println(const char*, ...);
void print(const char*, ...);
/**
 * @brief Dump hexadecimal and ASCII values of o buffer
 * 
 * @param buf Pointer to buffer 
 * @param start Indext of first byte
 * @param len Number of bytes
 */
void hexdump(const uint8_t*, const uint16_t, const size_t);

#endif
