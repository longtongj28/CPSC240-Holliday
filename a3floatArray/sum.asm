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
;   File name: sum.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l sum.lis -o sum.o sum.asm
;   Link: g++ -m64 -no-pie -o addFloatArray.out control.o fill.o main.o sum.o display.o -std=c++17
;   Purpose: Defines the sum function, which will take an array and number of elements to traverse and add them together.
;            The total is returned to the caller (control module).

;===== Begin code area ================================================================================================

global sum

segment .data

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

sum:

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

push qword 0 ; remain on the boundary
; Taking information from parameters
mov r15, rdi  ; This holds the first parameter (the array)
mov r14, rsi  ; This holds the second parameter (the number of elements in the array, not size)


; loop the array and add each value to a total.
mov rax, 1 ; one xmm register will be used
mov rdx, 0
cvtsi2sd xmm15, rdx ; convert the 0 in rdx to something xmm can read
mov r13, 0 ; for loop counter goes up to 5, starting at 0
beginLoop:
  cmp r13, r14  ;comparing increment with 6 (the size of array)
  je outOfLoop
  addsd xmm15, [r15 + 8*r13]; ;add to xmm15 the value at array[counter]
  inc r13  ;increment loop counter
  jmp beginLoop
outOfLoop:


pop rax ;push counter at the beginning

movsd xmm0, xmm15 ; returning sum to caller
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
