
#ifndef SCREEN_H // include guard 
#define SCREEN_H

#include <stdint.h>

void putchar(char c, int color);
void print(const char *text, const int color);
void print_hex(uint64_t n, int color);
void scroll(void);
void clear_screen(void);

#endif