nanode-flash-led
================

This is a basic pure-C program to flash the red LED on the [Nanode], an Arduino compatible board, with a built-in [ENC28J60] Ethernet controller. I have created it a starting point to help people write pure-C for their [Nanode].



Getting started on Mac OS X
---------------------------

I personally use [Homebrew] on my Mac, but it does not include avr-gcc in the main repository. However you can use the formulas from [CrossBuild tools for OSX] in the [homebrew-avr] repository:

    brew tap osx-cross/avr
    brew install avr-gcc avr-libc avr-binutils
    brew install avrdude

Alternatively, you could try following these instructions: http://www.ladyada.net/learn/avr/setup-mac.html

There are lots of other tutorials on Google.

Once you have done that check which serial port your Nanode is using:
   
    ls /dev/tty.*
   
Then edit the *SERIAL_PORT* definition in the Makefile.

You can then compile the binary:

    $ make
    avr-gcc -mmcu=atmega328p -DF_CPU=16000000UL -Wall -W -Os -o nanode-flash-led.o -c nanode-flash-led.c
    avr-gcc -mmcu=atmega328p -Wl -o nanode-flash-led.elf nanode-flash-led.o
    avr-objcopy nanode-flash-led.elf -j .text -j .data -O ihex nanode-flash-led.hex
    avr-size nanode-flash-led.elf
       text	   data	    bss	    dec	    hex	filename
        214	      0	      0	    214	     d6	nanode-flash-led.elf

And then upload it to your Nanode:

    $ make load
    avrdude -q -P /dev/tty.usbserial-A700fbtR -c arduino -b 57600 -p atmega328p -e -U flash:w:nanode-flash-led.hex
    
    avrdude: AVR device initialized and ready to accept instructions
    avrdude: Device signature = 0x1e950f
    avrdude: erasing chip
    avrdude: reading input file "nanode-flash-led.hex"
    avrdude: input file nanode-flash-led.hex auto detected as Intel Hex
    avrdude: writing flash (214 bytes):
    avrdude: 214 bytes of flash written
    avrdude: verifying flash memory against nanode-flash-led.hex:
    avrdude: load data flash data from input file nanode-flash-led.hex:
    avrdude: input file nanode-flash-led.hex auto detected as Intel Hex
    avrdude: input file nanode-flash-led.hex contains 214 bytes
    avrdude: reading on-chip flash data:
    avrdude: verifying ...
    avrdude: 214 bytes of flash verified
    
    avrdude: safemode: Fuses OK
    
    avrdude done.  Thank you.



Getting started on Debian
-------------------------

Install the AVR compiler and programmer:

    $ apt-get install gcc-avr binutils-avr avr-libc avrdude

Check which port your Nanode serial port is connected to:

    $ dmesg | grep ttyUSB
    [13813.441251] usb 2-1: FTDI USB Serial Device converter now attached to ttyUSB0

Then edit the *SERIAL_PORT* definition in the Makefile:
   
    SERIAL_PORT = /dev/ttyUSB0

THen follow the compilation instructions above.


[Arduino]:                  https://www.arduino.cc/
[Homebrew]:                 http://mxcl.github.com/homebrew/
[CrossBuild tools for OSX]: https://github.com/osx-cross
[homebrew-avr]:             https://github.com/osx-cross/homebrew-avr
[enc28j60]:                 http://www.microchip.com/enc28j60
[Nanode]:                   http://nanode.eu/

