;****************************************************************************************************************************
;Program name: "Quadratic". This program takes in 3 float numbers as coefficients to determine whether or not they fit the
; criteria for a quadratic equation. It will calculate the discriminant and validate input to find roots or let the user know
; there is no root. Copyright (C) 2021 Johnson Tong.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Quadratic".                                                                   *
;Quadratic is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Quadratic is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
;  Program name: Quadratic
;  Programming languages: One module in C, one module in X86, two modules in C++
;  Date program began: 2021 Feb 17
;  Date of last update: 2021 Feb 28
;  Date of reorganization of comments: 2021 Feb 28
;  Files in this program: quadratic.asm, second_degree.c, isFloat.cpp, quad.cpp, run.sh
;  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
;
;Purpose: Assembly file that defines the function findRoots which is used in the driver
;         second_degree.c.

;This file
;   File name: quadratic.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm
;   Link: g++ -m64 -no-pie -o finalQuadratic.out quadratic.o quad.o isFloat.o second_degree.o -std=c++17

;===== Begin code area ================================================================================================
extern printf
extern scanf
extern atof
extern isFloat
extern show_no_root
extern show_one_root
extern show_two_root
global findRoots

segment .data
welcome db "This program will find the roots of any quadratic equation.", 10, 0

inputprompt db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c. Press enter after each number: ", 0
three_string_format db "%s%s%s",0
show_quadratic db "Thank you. The equation is %.9lfx^2 + %.9lfx + %.9lf = 0.0.", 10, 0
one_return db "One of these roots will be returned to the caller function.", 10, 0
invalid db "Invalid input data detected. You may run this program again.", 10, 0
not_quadratic db "This is not a quadratic equation. You may run this program again.", 10, 0

HELLO_VAR db "HELLOOOOOOO", 10, 0
JOHNSON db "jOHNson", 10, 0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

findRoots:

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
; planning for assignment 2
;welcome
;prompt for first_name and last name
;scanf for those inputs
;show prompt for job title
;print ...
;enter the height
;calculate the time it takes for free fall 1/2*g*t^2 = h
;sqrt(2h/g)
;g = 9.8

; jl, jle, je, jne, jg, jge

; if (rax <= 30) print out "HELLOOOOOOO"
; else print out "Johnson"


; IF (X != 27) print out "Not 27"
;Registers rax, rip, and rsp are usually not backed up.
push qword 0

;==========Welcome and prompt============
push qword 0
mov rax, 0
mov rdi, welcome ; "This program will find the roots of any quadratic equation."
call printf
pop rax


push qword 0
mov r14, 30
mov r15, 20
cmp r14, r15
pop rax

jle next_part

push qword 0
mov rax, 0
mov rdi, JOHNSON
call printf
pop rax

next_part:
push qword 0
mov rax, 0
mov rdi, HELLO_VAR
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, inputprompt ; "Please enter the three floating point...."
call printf
pop rax
;===========Store the three floats a,b,c===============
push qword -1
sub rsp, 3072   ; make space for 3 strings (1024 bytes each)
mov rax, 0
mov rdi, three_string_format ;"%s%s%s"
mov rsi, rsp    ; first string on the stack
mov rdx, rsp
add rdx, 1024   ; allow space for second long string
mov rcx, rsp
add rcx, 2048  ; allow space for long strings
call scanf
;====== check invalid input =======
; must pass this test or will end program
mov rax, 0
mov rdi, rsp
call isFloat
cmp rax, 0        ;if not a float, jump to invalidRoot
je invalidRoot

mov rax, 0
mov rdi, rsp
add rdi, 1024
call isFloat
cmp rax, 0        ;if not a float, jump to invalidRoot
je invalidRoot

mov rax, 0
mov rdi, rsp
add rdi, 2048
call isFloat
cmp rax, 0        ;if not a float, jump to invalidRoot
je invalidRoot
;=========finish check=======================

;=========convert valid values to float===========
;             and store them
mov rdi, rsp
call atof
movsd xmm5,xmm0
mov rcx, 0          ; begin check if a is 0.0. if it is,
cvtsi2sd xmm0, rcx   ; it's not a possible quadratic equation
ucomisd xmm5, xmm0
je notQuadratic

mov rdi, rsp
add rdi, 1024
call atof
movsd xmm6, xmm0

mov rdi, rsp
add rdi, 2048
call atof
movsd xmm7, xmm0
;===========finished storing values========

pop rax   ;counter push from the beginning of scanf after passing validation test

; ======== display the equation=====
push qword 0
mov rax, 3
mov rdi, show_quadratic   ;"Thank you! The quadratic equation is ....."
movsd xmm0, xmm5          ; storing the valid coefficient floats
movsd xmm1, xmm6
movsd xmm2, xmm7
call printf
pop rax

; ==========calculate the roots============
;-b +/- sqrt(b^2-4ac) / 2a
;first root:
; -b
mov rbx, -1
cvtsi2sd xmm8, rbx
mulsd xmm8, xmm6 ; -1*b
; sqrt(b^2-4ac)
movsd xmm9, xmm6 ; copy b
mulsd xmm9, xmm9 ; b*b
mov rcx, 4
cvtsi2sd xmm10, rcx
mulsd xmm10, xmm5 ; 4*a
mulsd xmm10, xmm7 ; 4*a*c
subsd xmm9, xmm10 ; b*b - 4ac, discriminant
sqrtsd xmm11, xmm9 ; sqrt(discriminant)
; 2 * a
mov rdx, 2
cvtsi2sd xmm15, rdx
mulsd xmm15, xmm5

movsd xmm12, xmm8   ; copy -b
addsd xmm12, xmm11  ; -b + sqrt(...)
; doing the division of quad. form
; "all over 2*a"
divsd xmm12, xmm15

; second root:
subsd xmm8, xmm11   ; -b - sqrt(...)
; doing the division of quad. form
; "all over 2*a"
divsd xmm8, xmm15

;now the roots will be stored in xmm12 and xmm8

;=====display the roots if they exist ======
mov rax, 0
cvtsi2sd xmm14, rax
ucomisd xmm9, xmm14   ; comparing the discriminant with 0.0
jb noRoot             ; less than 0.0 hop to noRoot
je oneRoot            ; equal to 0.0 hop to oneRoot
ja twoRoot            ; greater than 0.0 hop to twoRoot

noRoot:
  push qword 0
  call show_no_root ; "No root was found."
  pop rax

  pop rax ; counter the push qword at the beginning of code
  movsd xmm0, xmm14   ; return 0.0 to the caller of function
  jmp endIf

oneRoot:
  push qword 0
  mov rax, 1
  movsd xmm0, xmm12
  call show_one_root  ; "One root was found: ...."
  pop rax

  pop rax ; counter the push qword at the beginning of code
  movsd xmm0, xmm12   ;return the root to the caller
  jmp endIf

twoRoot:
  push qword 0
  mov rax, 2
  movsd xmm0, xmm12
  movsd xmm1, xmm8
  call show_two_root   ;"The roots are .... and ..."
  pop rax

  push qword 0
  mov rdi, one_return ; "one of these roots will be returned..."
  call printf
  pop rax

  pop rax ; counter the push qword at the beginning of code
  movsd xmm0, xmm12 ; return one of the roots to the caller
  jmp endIf

invalidRoot:
  push qword 0
  mov rax, 0
  mov rdi, invalid ; "rerun the program"
  call printf
  pop rax
  ; push from scanf + 1 push at beginning of file
  pop rax

  pop rax

  mov rdx, 0
  cvtsi2sd xmm0, rdx   ;return 0.0 to the caller
  jmp endIf

notQuadratic:
  push qword 0
  mov rdi, not_quadratic
  call printf
  pop rax

  ; push from scanf + 1 push at beginning of file
  pop rax

  pop rax

  mov rdx, 0
  cvtsi2sd xmm0, rdx   ;return 0.0 to the caller

endIf:        ; end of if statements/end of program
add rsp, 3072 ; counter the space made at the beginning of the program for 3 strings

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
