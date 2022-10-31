; //****************************************************************************************************************************
; //Program name: "_start". This program is will output the number of tics from the cpu, take a float input, convert the user input into radians,
; //               call cosine, and output the results all from pure x86 assembly.
; //               Copyright (C) 2022 Timothy Vu.
; //                                                                                                                           *
; //This file is part of the software program "_start".                                                                   *
; //_start is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
; //version 3 as published by the Free Software Foundation.                                                                    *
; //_start is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
; //warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *

; //A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *


; //****************************************************************************************************************************
; //=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**//

; //Author information
; //  Author name: Timothy Vu
; //  Author email: timothy.vu@csu.fullerton.edu
; //  Author Section: M/W 2:00pm-3:50pm
; //
; //Program information
; //  Program name: _start
; //  Programming languages: seven modules in X86
; //  Date program began: 2022 October 23
; //  Date of last update: 2022 October 26
; //  Date of reorganization of comments: 2022 October 27
; //  Files in this program: _start.asm, _math.asm, cosine.asm, ftoa.asm, itoa.asm, stringtof.asm strlen.asm
; //  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
; //
; //Purpose
; //  The purpose of this file is to output the number of tics from the cpu, take user input, convert the user input into radians, call
; //  the cosine file, and output the results from pure assembly
; //
; //This file
; //   File name: _start.asm
; //   Language: x86
; //   Max page width: 172 columns
; //   Compile: nasm -f elf64 -l _start.lis -o _start.o _start.asm 
; //   Linker: ld -o final.out _start.o strlen.o cosine.o itoa.o _math.o ftoa.o stringtof.o 
; //
; //=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; //
; //
; //===== Begin code area ===========================================================================================================

extern strlen
extern itoa
extern cosine
extern ftoa
extern stringtof

global _start

sys_write equ 1
sys_read equ 0
stdout equ 1
stdin equ 0

Numeric_string_array_size equ 32

segment .data

newline db 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0        ;Declare an array of 8 bytes where each byte is initialize with ascii value 10 (newline)                                   
tab db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0    ;Declare an array of 8 bytes where each byte is initialize with 32 (blank space).  Thus, this array equals 
                                                            ;one standard tab.
welcome db "Welcome to Accurate Cosines by Timothy Vu.", 10, 0

time db "The time is now ", 0
time2 db " tics.", 10, 0

angle_prompt db "Please enter an angle in degrees and press enter: ", 10, 0
entered db "You entered ", 0

radians db "The equivalent radians is ", 0

cosine_prompt db "The cosine of those degrees is ", 0

bye db "Have a nice day. Bye", 10, 0

segment .bss

tic resb 50
tic2 resb 50
input_integer_string resb Numeric_string_array_size
output_string resb Numeric_string_array_size

float_string resb 30

cos_string resb 30

segment .text

_start:

push rbp                                          ;Backup rbp
mov  rbp,rsp                                      ;The base pointer now points to top of stack
push rdi                                          ;Backup rdi
push rsi                                          ;Backup rsi
push rdx                                          ;Backup rdx
push rcx                                          ;Backup rcx
push r8                                           ;Backup r8
push r9                                           ;Backup r9
push r10                                          ;Backup r10
push r11                                          ;Backup r11
push r12                                          ;Backup r12
push r13                                          ;Backup r13
push r14                                          ;Backup r14
push r15                                          ;Backup r15
push rbx                                          ;Backup rbx
pushf                                             ;Backup rflags

;get strlen of welcome
mov rax, 0
mov rdi, welcome
call strlen
mov r15, rax

;output welcome
mov rax, sys_write
mov rdi, stdout
mov rsi, welcome
mov rdx, r15
syscall

;get strlen of time
mov rax, 0
mov rdi, time
call strlen
mov r15, rax

;output time prompt
mov rax, sys_write
mov rdi, stdout
mov rsi, time
mov rdx, r15
syscall

;get time
cpuid
rdtsc
shl rdx, 32
or rdx, rax
mov r14, rdx

;call itoa
mov rax, 0
mov rdi, r14
mov rsi, tic
call itoa
mov r13, tic

;get strlen of the time
mov rax, 0
mov rdi, r13
call strlen
mov r15, rax

;output the time
mov rax, sys_write
mov rdi, stdout
mov rsi, r13
mov rdx, r15
syscall

;get strlen of time2
mov rax, 0
mov rdi, time2
call strlen
mov r15, rax

;output time2
mov rax, sys_write
mov rdi, stdout
mov rsi, time2
mov rdx, r15
syscall

;get strlen of angle_prompt
mov rax, 0
mov rdi, angle_prompt
call strlen
mov r15, rax

;output angle_prompt
mov rax, sys_write
mov rdi, stdout
mov rsi, angle_prompt
mov rdx, r15
syscall

;Input char from keyboard one byte at a time.

;Preloop initialization
    mov rbx, input_integer_string
    mov r12,0       ;r12 is counter of number of bytes inputted
    push qword 0    ;Storage for incoming byte

Begin_loop:         ;This is the one point of entry into the loop structure.
    mov    rax, sys_read
    mov    rdi, stdin
    mov    rsi, rsp
    mov    rdx, 1    ;one byte will be read from the input buffer
    syscall

    mov al, byte [rsp]

    cmp al, 10
    je Exit_loop     ;If EOL is encountered then discard EOL and exit the loop.
                    ;This is the only point in the loop structure where exit is allowed.

    inc r12          ;Count the number of bytes placed into the array.

    ;Check that the destination array has not overflowed.
    cmp r12,Numeric_string_array_size
    ;if(r12 >= Input_array_size)
         jge end_if_else
    ;else (r12 < Numeric_string_array_size)
          mov byte [rbx],al
          inc rbx
    end_if_else:

jmp Begin_loop

Exit_loop:
    mov byte [rbx], 0        ;Append the null character.

    pop rax          ;Return the stack to its former state.
;input_integer_string holds the user input.  However, if the user inputted more than (Numeric_string_array_size - 1)
;bytes then the excess will be discarded.  The last byte in the array is reserved for the null char.

;get strlen of entered
mov rax, 0
mov rdi, entered
call strlen
mov r15, rax

;output entered
mov rax, sys_write
mov rdi, stdout
mov rsi, entered
mov rdx, r15
syscall

;get strlen of inputted number
mov rax, 0
mov rdi, input_integer_string
call strlen
mov r15, rax

;output input_integer_string
mov rax, sys_write
mov rdi, stdout
mov rsi, input_integer_string
mov rdx, r15
syscall

;output newline
mov rax, sys_write
mov rdi, stdout
mov rsi, newline
mov rdx, 1
syscall

;call stringtof
mov rax, 0
mov rdi, input_integer_string
call stringtof
movsd xmm8, xmm0

;get strlen of radians
mov rax, 0
mov rdi, radians
call strlen
mov r15, rax

;output radians
mov rax, sys_write
mov rdi, stdout
mov rsi, radians
mov rdx, r15
syscall

;get radian value
mov rbx, 180
cvtsi2sd xmm10, rbx
mov rax, 0x400921FB54442D18
push rax
movsd xmm9, [rsp]
pop rax

mulsd xmm8, xmm9
divsd xmm8, xmm10

;call ftoa to get radian value
mov rax, 1
movsd xmm0, xmm8
mov rdi, float_string
mov rsi, 30
call ftoa
mov r12, rax

;output radian value
mov rax, sys_write
mov rdi, stdout
mov rsi, float_string
mov rdx, r12
syscall

;output newline
mov rax, sys_write
mov rdi, stdout
mov rsi, newline
mov rdx, 1
syscall

;call cosine
mov rax, 1
movsd xmm0, xmm8
call cosine
movsd xmm9, xmm0

;get strlen of cosine_prompt
mov rax, 0
mov rdi, cosine_prompt
call strlen
mov r15, rax

;output cosine_prompt
mov rax, sys_write
mov rdi, stdout
mov rsi, cosine_prompt
mov rdx, r15
syscall

;;;;;;;;;;;;;;;;; Call ftoa and output the string ;;;;;;;;;;;;;;;;;;;;;;
; call ftoa
mov rax, 1
movsd xmm0, xmm9
mov rdi, cos_string
mov rsi, 30
call ftoa
mov r12, rax

;output float_string
mov rax, sys_write
mov rdi, stdout
mov rsi, cos_string
mov rdx, r12
syscall

;output newline
mov rax, sys_write
mov rdi, stdout
mov rsi, newline
mov rdx, 1
syscall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;get strlen of time
mov rax, 0
mov rdi, time
call strlen
mov r15, rax

;output time
mov rax, sys_write
mov rdi, stdout
mov rsi, time
mov rdx, r15
syscall

;get time
cpuid
rdtsc
shl rdx, 32
or rdx, rax
mov r14, rdx

; mov rax, cpu_freq
; div r14

;call itoa
mov rax, 0
mov rdi, r14
mov rsi, tic2
call itoa
mov r13, tic2
; mov rax, cpu_freq           ;divide be cpu_freq to get seconds
; div r13

;get strlen of the time
mov rax, 0
mov rdi, r13
call strlen
mov r15, rax

;output the time
mov rax, sys_write
mov rdi, stdout
mov rsi, r13
mov rdx, r15
syscall

;get strlen of time2
mov rax, 0
mov rdi, time2
call strlen
mov r15, rax

;output time2
mov rax, sys_write
mov rdi, stdout
mov rsi, time2
mov rdx, r15
syscall

;get strlen of bye
mov rax, 0
mov rdi, bye
call strlen
mov r15, rax

;output bye
mov rax, sys_write
mov rdi, stdout
mov rsi, bye
mov rdx, r15
syscall

;=====Now exit from this program and return control to the OS =============================================================================================================
mov        rax, 60                                          ;60 is the number of the syscall subfunction that terminates an executing program.
mov        rdi, 0                                           ;0 is the code number that will be returned to the OS.
syscall
;We cannot use an ordinary ret instruction here because this program was not called by some other module.  The program does not know where to return to.


popf                                    ;Restore rflags
pop rbx                                 ;Restore rbx
pop r15                                 ;Restore r15
pop r14                                 ;Restore r14
pop r13                                 ;Restore r13
pop r12                                 ;Restore r12
pop r11                                 ;Restore r11
pop r10                                 ;Restore r10
pop r9                                  ;Restore r9
pop r8                                  ;Restore r8
pop rcx                                 ;Restore rcx
pop rdx                                 ;Restore rdx
pop rsi                                 ;Restore rsi
pop rdi                                 ;Restore rdi
pop rbp                                 ;Restore rbp

ret
