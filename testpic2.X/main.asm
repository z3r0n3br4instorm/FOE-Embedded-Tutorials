#include <xc.inc>
 ;define address
PORTD   equ 0x08
TRISD   equ 0x88
PORTB   equ 0x06
TRISB   equ 0x86
STATUS  equ 0x03
 
 psect barfunc, local, class=CODE,delta=2 ; PIC10/12/16
 org 0x00 ; set origin vector, whereto begin
 ;accessing the bank 1
 BCF STATUS,6 ; CLEAR 6TH BIT IN THE STATUS REGISTER
 BSF STATUS,5 ; SET 5TH BIT IN STATUS REGISTER
 ;CODE FOR GLOWING TWO LEDS IN PORTS 0 AND 1
 ;CLRF TRISD
 ;BCF STATUS, 5
 ;MOVLW 0b0000011;
 ;MOVWF PORTD
 ;TESTING THE SWITCH
 BSF TRISB, 0
 CLRF TRISD
 BCF STATUS, 5
 GOTO loopInit
 
 loopInit:
    BTFSS PORTB,1
    GOTO led_on
    GOTO led_off
    led_on:
       MOVLW 0xff
       MOVWF PORTD
    led_off:
       MOVLW 0x00;
       MOVWF PORTD
 GOTO loopInit
 end