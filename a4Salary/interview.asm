;****************************************************************************************************************************
;Program name: "Paramount Interviews".  A funny program made in assembly/C++ that shows a unrealistic job interview.
;               Three text files are included to show the possible unique outputs.
; Copyright (C) 2021 Johnson Tong.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Interview".                                                                   *
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
;  Program name: Paramount Interviews
;  Programming languages: Assembly, C++, bash
;  Date program began: 2021 April 11
;  Date of last update: 2021 April 22
;  Date of reorganization of comments: 2021 April 22
;  Files in this program: interview.asm, main.cpp, r.sh, chris.txt, social.txt, csmajor.txt
;  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition (Linux).
;
;This file
;   File name: interview.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l interview.lis -o interview.o interview.asm
;   Link: g++ -m64 -no-pie -o interview.out main.o interview.o -std=c++17
;   Purpose: The "personnel manager" who will interview the user is defined here in the interview module.
;            This function takes in a name character array and a salary double and produces technical
;            interview questions. Will be called in main.cpp and returns a double (actual salary).
;========================================================================================================

extern printf
extern scanf
global interview

segment .data
welcome db "Hello %s. I am Ms Fenster. The interview will begin now.",10,0
wow db "Wow! $%.2lf, That's a lot of cash. Who do you think you are, Chris Sawyer? (enter y or n) ", 10, 0
one_string_format db "%s", 0
alright db "Alright. Now we will work on your electricity.", 10, 0
input_prompt db "Please enter the resistance of circuit #1 in Ohms: ", 10, 0
input_prompt_2 db "Please enter the resistance of circuit #2 in Ohms: ", 10, 0
one_float_format db "%lf", 0

tell_total_resistance db "The total resistance is %.16lf Ohms.", 10, 0
ask_major db "Were you a computer science major? (enter y or n) ", 10, 0
thank_you db "Thank you. Please follow the exit signs to the front desk.", 10, 0

CS_salary dq 0x40F57C0E147AE148
Sawyer_salary dq 0x4197D78400000000
Non_CS_salary dq 0x4092C07AE147AE14

segment .bss

segment .text

interview:
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

;Registers rax, rip, and rsp are usually not backed up.
push qword 0
; This module controls the interview function, which has parameters char[], double

; ============================================================================================
; Preserving these values
mov r12, rdi              ; r12 contains the potential emloyee's name
movsd xmm15, xmm0      ; xmm15 now contains the desired salary (double)
; ============================================================================================

; "Hello %s. I am Ms Fenster. The interview will begin now."
push qword 0
mov rax, 0
mov rdi, welcome
mov rsi, r12
call printf
pop rax

; ============================================================================================
; "Wow! $%.2lf, That's a lot of cash. Who do you think you are, Chris Sawyer? (enter y or n) "
push qword 0
mov rax, 1
mov rdi, wow
movsd xmm0, xmm15
call printf
pop rax
; Then we will store that inputted character in rdx
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, rsp
call scanf
mov rdx, [rsp]
pop rax
; ============================================================================================

; ============================================================================================
; The messages are in chronological order.
; if the answer was "y" then skip to byeGoToFront block. Else, do the electric calculation.
mov rcx, 121                                          ; "y" in ascii
cmp rdx, rcx                                          ; rdx stores user input from last prompt
je giveSawyerBucks

; =========================== Begin Electric Calculations ==================================
electricCalculations:
;"Alright. Now we will work on your electricity."
push qword 0
mov rax, 0
mov rdi, alright
call printf
pop rax

; ================================ Prompt 1 ============================================
;"Please enter the resistance of circuit #1 in ohms: "
push qword 0
mov rax, 0
mov rdi, input_prompt
call printf
pop rax
; allow the float input into xmm13
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm13, [rsp]
pop rax
; =========================== End Prompt 1 ===============================================

; ================================ Prompt 2 ============================================
;"Please enter the resistance of circuit #2 in ohms: "
push qword 0
mov rax, 0
mov rdi, input_prompt_2
call printf
pop rax
; allow the float input into xmm12
push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
pop rax
; =========================== End Prompt 2 ===============================================

; ================= Total Resistance Calculations =======================================
; the formula: 1/(1/ohm1 + 1/ohm2) = total
; resistances are stored in xmm13 and xmm12
; storing ones first
mov r11, 1
cvtsi2sd xmm11, r11           ;I'm going to use "1.0" 3 times, copying for efficiency
movsd xmm10, xmm11
movsd xmm9, xmm11

; doing the two divisions inside the parentheses and adding them together (formula above)
divsd xmm11, xmm13
divsd xmm10, xmm12
addsd xmm10, xmm11
; now doing 1/addition. Our total is stored in xmm9
divsd xmm9, xmm10
; ================= End Resistance Calculations =======================================

;"The total resistance is %.16lf Ohms." The format will be filled by the value in xmm9
push qword 0
mov rax, 1                                  ;using 1 register
mov rdi, tell_total_resistance
movsd xmm0, xmm9
call printf
pop rax
; ========================== End total electric calculations ====================================

; ================================ Ask for Major =========================================
;"Were you a computer science major? (enter y or n) "
push qword 0
mov rax, 0
mov rdi, ask_major
call printf
pop rax
; store the input in r9
push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, rsp
call scanf
mov r9, [rsp]
pop rax

mov rcx, 121
cmp r9, rcx
je giveCSBucks
; ================================ End Ask for Major ======================================

; ============================== Salary Decisions ======================================
giveNonCSBucks:
;"Thank you. Please follow the exit signs to the front desk."
push qword 0
mov rax, 0
mov rdi, thank_you
call printf
pop rax

pop rax ;countering push at beginning

mov rax, 0x4092C07AE147AE14         ; $1200.12 in hex
push rax
movsd xmm5, [rsp]
pop rax

jmp finished

giveCSBucks:
;"Thank you. Please follow the exit signs to the front desk."
push qword 0
mov rax, 0
mov rdi, thank_you
call printf
pop rax

pop rax ;countering push at beginning

mov rax, 0x40F57C0E147AE148             ;$88000.88 in hex
push rax
movsd xmm5, [rsp]
pop rax

jmp finished

giveSawyerBucks:
;"Thank you. Please follow the exit signs to the front desk."
push qword 0
mov rax, 0
mov rdi, thank_you
call printf
pop rax

pop rax ;countering push at beginning

mov rax, 0x4197D78400000000       ; 1 million in hex
push rax
movsd xmm5, [rsp]
pop rax

jmp finished

; ============================== End Salary Decisions ======================================

finished:
movsd xmm0, xmm5
; ============================================================================================


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
