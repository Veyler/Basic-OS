#include <stdint.h>
#include "screen.h"
#define VGA ((volatile unsigned short *)0xB8000)

int screen_location = 0;

void putchar(char c, int color){
    while (screen_location >= 80 * 25)
        scroll();

    if (c == '\n')
        screen_location = (screen_location / 80 + 1) * 80;
    else
        VGA[screen_location++] = color | c;
}

void print(const char *text, const int color){
    for (int i = 0; text[i] != '\0'; i++)
        putchar(text[i], color);
}

void print_hex(uint64_t n, int color){
    char *chars = "0123456789ABCDEF";
    char hex[19];
    int i = 18;
    hex[i--] = '\0';

    if (n == 0){
        hex[i--] = '0';
    } else {
        while (n > 0){
            hex[i--] = chars[n & 0xF];    // On récupère les 4 derniers bits
            n >>= 4;                      // Décaler de 4 birs vers la droite
        }
    }

    hex[i--] = 'x';
    hex[i] = '0';

    print(&hex[i], color);

}

void scroll(void){
    for (int i = 0; i < 80*(25-1); i++){
        VGA[i] = VGA[i + 80];
    }
    for (int i = 80*(25-1); i < 80*25; i++){
        VGA[i] = 0x0720;
    }
    screen_location -= 80;
}

void clear_screen(void){
    for (int i = 0; i < 80 * 25; i++)
        VGA[i] = 0x0720;   
    screen_location = 0; 
}