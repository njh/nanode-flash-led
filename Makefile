
# Set this to the serial port that your Nanode is connected to
# (on Mac OS X use 'ls /dev/tty.usbserial*' to get the name)
SERIAL_PORT = /dev/tty.usbserial-A700fbtR

# Nanode settings
AVR_MCU = atmega328p
AVR_MCU_SPEED = 16000000UL
AVRDUDE_OPTIONS = -q -P $(SERIAL_PORT) -c arduino -b 57600 -p $(AVR_MCU)

# AVR Compiler definitions
CC       = avr-gcc
LD       = avr-gcc
ELF_SIZE = avr-size
OBJCOPY  = avr-objcopy
CFLAGS   = -mmcu=$(AVR_MCU) -DF_CPU=$(AVR_MCU_SPEED) -Wall -W -Os
LDFLAGS  = -mmcu=$(AVR_MCU)


all: nanode-flash-led.hex

nanode-flash-led.elf: nanode-flash-led.o
	$(CC) $(LDFLAGS) -o $@ $^

load: nanode-flash-led.hex
	avrdude $(AVRDUDE_OPTIONS) -e -U flash:w:$<

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $^

%.hex: %.elf
	$(OBJCOPY) $^ -j .text -j .data -O ihex $@
	$(ELF_SIZE) $^

clean:
	rm -f *.o *.elf *.hex


.PHONY: all clean
