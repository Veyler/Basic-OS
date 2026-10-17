#define VGA ((volatile unsigned short *)0xB8000)

int screen_location = 0;

void clear_screen(void);
void print(const char *text, const int color);
void scroll(void);

void kernel_main(void){
    clear_screen();

    print("Welcome to Basic OS \n", 0x0100);
    print("Find the code in https://github.com/Veyler/Basic-OS", 0x0600);


    while(1) {
        __asm__("hlt");
    }   
}

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
