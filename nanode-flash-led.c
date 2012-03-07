/*
 * Basic pure-C program to flash the red LED on the Nanode
 * 
 * The Red LED is connected to Pin 6 of Port D:
 * http://wiki.london.hackspace.org.uk/view/Project:Nanode/docs
 *
 */

#include <avr/io.h>
#include <util/delay.h>

#define NANODE_RED_LED    PD6

// Some macros that make the code more readable
#define OUTPUT_LOW(port,pin)    port &= ~(1<<pin)
#define OUTPUT_HIGH(port,pin)   port |= (1<<pin)
#define SET_INPUT(portdir,pin)  portdir &= ~(1<<pin)
#define SET_OUTPUT(portdir,pin) portdir |= (1<<pin)


int main(void)
{
  SET_OUTPUT(DDRD, NANODE_RED_LED);

  while (1) {
   OUTPUT_HIGH(PORTD, NANODE_RED_LED);
   _delay_ms(1000);
   OUTPUT_LOW(PORTD, NANODE_RED_LED);
   _delay_ms(1000);
  }
  
  return 0;
}
