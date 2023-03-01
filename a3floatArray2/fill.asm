;****************************************************************************************************************************
;Program name: "Add Float Array".
; This program will allow a user to input float numbers in an array of size 6, and display the contents. It will also add
; them together and display the result.
; Copyright (C) 2021 Johnson Tong.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Add Float Array".
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Johnson Tong
;  Author email: jt28@csu.fullerton.edu
;
;Program information
;  Program name: Add Float Array
;  Programming languages: Assembly, C++, C, bash
;  Date program began: 2021 March 10
;  Date of last update: 2021 March 21
;  Date of reorganization of comments: 2021 March 21
;  Files in this program: control.asm, main.c, display.cc, sum.asm, fill.asm, run.sh
;  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
;
;This file
;   File name: fill.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l fill.lis -o fill.o fill.asm
;   Link: g++ -m64 -no-pie -o addFloatArray.out control.o fill.o main.o sum.o display.o -std=c++17
;   Purpose: Defines the function that will take in the array from the control module and prompt the user to
;            input floats into the array. Additionally, it will return the number of elements (not size) back to the
;            caller.
;========================================================================================================
extern printf
extern scanf
extern stdin
extern clearerr
extern isfloat
extern atof

global fill

segment .data

enter_prompt db "Please enter up to 6 floating point numbers separated by ws,", 10, 0
enter_prompt_two db "When finished press enter followed by Cntrl+D.", 10, 0
float_format db "%lf", 0
one_string_format db "%s", 0
; test db "A", 0xE2, 0x8A, 0x95," B contains", 10, 0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

fill:

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword 0 ;staying on the boundary

; Taking information from parameters
mov r15, rdi  ; This holds the first parameter (the array)
mov r14, rsi  ; This holds the second parameter (the size of array)

;Prompts:
;"Please enter floating point numbers separated by ws,"
;"When finished press enter followed by Cntrl+D."

push qword 0
mov rax, 0
mov rdi, enter_prompt
call printf
pop rax
push qword 0
mov rax, 0
mov rdi, enter_prompt_two
call printf
pop rax

; let user enter numbers until cntrl + d is entered
; this for loop will go to 6, the chosen array size, or end once cntrl d is pressed.
mov r13, 0 ; for loop counter
beginLoop:
  cmp r14, r13 ; we want to exit loop when we hit the size of array
  je outOfLoop
  mov rax, 0
  mov rdi, float_format
  push qword 0
  mov rsi, rsp
  call scanf
  cdqe
  cmp rax, -1  ; loop termination condition: user enters cntrl + d.
  pop r12
  je outOfLoop
  mov [r15 + 8*r13], r12  ;at array[counter], place the input number
  inc r13
  ; converting string to float
  ; Take in a String
  ; Check if it's a float
  ; mov rdi, rsp
  ; call isfloat
  ; ; if float continue, otherwise jump back to beginning
  ; cmp rax, -1
  ; jne beginLoop
  ; ; Convert it to a float
  ; mov rdi, rsp
  ; call atof
  ; ; result is in xmm0
  ; movsd [r15 + 8*r13], xmm0  ;at array[counter], place the input number
  ; inc r13  ;increment loop counter
  ; pop rax
  jmp beginLoop
outOfLoop:
; use jumps to skip certain statements
; Clear the input stream of "cntrl+d"
mov rax, 0
mov rdi, [stdin]
call clearerr

pop rax ; counter push at the beginning
mov rax, r13  ; store the number of things in the aray from the counter of for loop

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
