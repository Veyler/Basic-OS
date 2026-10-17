#define VGA ((volatile unsigned short *)0xB8000)

void clear_screen(void);

void kernel_main(void) {
    clear_screen();

    const char *str = "Hello from the c kernel !";
    for (int i = 0; str[i] != '\0'; i++){
        VGA[i] = 0x0700 | str[i];
    }

    while(1) {
        __asm__("hlt");
    }   
}

void clear_screen(void) {
    for (int i = 0; i < 80 * 25; i++)
        VGA[i] = 0x0720;    // gris clair sur fond noir
}
