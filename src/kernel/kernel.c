#include "screen/screen.h"

void kernel_main(void){
    clear_screen();

    print("Welcome to Basic OS \n", 0x0100);
    print("Find the code in https://github.com/Veyler/Basic-OS \n", 0x0600);

    print_hex(0x000FF, 0x0600);

    while(1) {
        __asm__("hlt");
    }   
}


