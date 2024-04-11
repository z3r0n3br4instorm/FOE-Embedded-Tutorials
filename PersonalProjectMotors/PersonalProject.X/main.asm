#include<xc.inc>
    
;Defining Addresses
PORTD   equ 0x08
TRISD   equ 0x88
PORTB   equ 0x06
TRISB   equ 0x86
STATUS  equ 0x03
  
psect barfunc, local, class=CODE,delta=2 ; PIC10/12/16
 
org 0x00
 
;Moving To the 1st bank
 BCF STATUS, 6
 BSF STATUS, 5
 
;Setting PORTB 0 as a input 
 BSF TRISB, 0
 
;Initializing Register D as output
 CLRF TRISD

;Switching to PORT Mode
 BCF STATUS, 5
 
;Testing Motor Control
; BSF PORTD, 0
 
 motorActiveLoop:
    BTFSC PORTB, 1
    goto Motor0Active
    BTFSC PORTB, 2
    goto Motor1Active
    BTFSC PORTB, 3
    goto AllMotorActive
    MOVWF 0x00
    MOVWF PORTD

    Motor0Active:
       BSF PORTD, 0
       goto motorActiveLoop
    Motor1Active:
       BSF PORTD, 1
       goto motorActiveLoop
    AllMotorActive:
       MOVLW 0xff
       MOVWF PORTD
       goto motorActiveLoop
 goto motorActiveLoop
; MOVLW 0xff
; MOVWF PORTD