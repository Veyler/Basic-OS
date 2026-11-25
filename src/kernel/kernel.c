#include "screen/screen.h"

void kernel_main(void){
    clear_screen();

    print("Welcome to Basic OS \n", 0x0600);
    print("Find the code in https://github.com/Veyler/Basic-OS \n", 0x0600);

    print("Print_hex function demo : ", 0x0600);
    print_hex(0xFF, 0x0600);

    while(1) {
        __asm__("hlt");
    }   
}
