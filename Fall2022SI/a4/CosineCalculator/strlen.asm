
;===== Function strlen ==================================================================================================
;************************************************************************************************************************
;Program name: "strlen".  This program computes the length of a string exclusive of the terminating null character.     *
;This is a library function not specific to any one program.  Copyright (C) 2018  Floyd Holliday                        *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public      *
;License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will  *
;be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR  *
;PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public License v3 is         *
;available here:  <https://www.gnu.org/licenses/>.                                                                      *
;************************************************************************************************************************

;Author information
;   Author name: Floyd Holliday
;   Author's email: holliday@fullerton.edu

;Function information
;   Function name: strlen
;   Programming language: X86
;   Language syntax: Intel
;   Function prototype:  int strlen(char *) 
;   Reference: none
;   Input parameter: an address to a byte in memory where a null-terminate string begins.
;   Output parameter: An integer representing the count of bytes in the string without counting the null char.

;Assemble: nasm -f elf64 -o strlen.o -l strlen.lis strlen.asm

;Date development began: 2018-April-15
;Date comments restructured: 2022-July-15


;===== Begin code section ==============================================================================================

;Declarations
global strlen

section .data
;This section is empty.

section .bss
;This section is empty.

section .text
strlen:

;===== Backup segment ==================================================================================================
;No floating point data are used in this program.  Therefore, state components FPU, SSE, AVX are not backed up.

;=========== Back up all the GPR registers except rax, rsp, and rip ====================================================

push       rbp                          ;Save a copy of the stack base pointer
mov        rbp, rsp                     ;We do this in order to be fully compatible with C and C++.
push       rbx                          ;Back up rbx
push       rcx                          ;Back up rcx
push       rdx                          ;Back up rdx
push       rsi                          ;Back up rsi
push       rdi                          ;Back up rdi
push       r8                           ;Back up r8
push       r9                           ;Back up r9
push       r10                          ;Back up r10
push       r11                          ;Back up r11
push       r12                          ;Back up r12
push       r13                          ;Back up r13
push       r14                          ;Back up r14
push       r15                          ;Back up r15
pushf                                   ;Back up rflags

;===== Application strlen begins here ==================================================================================

;Set up registers needed by the repnz instruction.
;rdi already holds the starting address of the array of char (the string).
xor        rcx, rcx                             ;This is a fast technique that zeros out rcx
not        rcx                                  ;This is a fast instruction that flips all bits in rcx.  rcx now holds 0xFFFFFFFFFFFFFFFF, which is both -1 and 
;                                               ;the largest unsigned integer.  The same result could have been obtained by "mov rcx, 0xFFFFFFFFFFFFFFFF", but 
;                                               ;that is a slower operation.
xor        al, al                               ;Set the lowest 8 bits (1 byte) of rax to zero.  There is no need to use extra machine time to zero out all of 
;                                               ;rax because repnz only uses the lowest 8 bits of rax.
cld                                             ;Clear the direction flag, which is a single bit inside of rflags register.  The term "clear" means "give it a
;                                               ;value of 0.  When the direction bit is zero the register rdi will increment by 1 in each iteration of the 
;                                               ;loop; otherwise, rdi will decrement in each iteration.
repnz      scasb                                ;This is a compact loop construction.  In pseudocode it does the following::
;                                                   ;repeat
;                                                   ;    {rcx--;
;                                                   ;     rdx++;
;                                                   ;    }
;                                                   ;until (rcx == 0 || [rdi] == al);
;Since it is very unlikely that rcx will decement to zero the loop effectively continues until [rdi] equals null 
;(the value in the lowest 1 byte or rax).  Notice that the null character is counted in the number of iterations 
;of the loop.  In the next statements the count will be adjusted to compensate for the extra iteration.

not        rcx                                  ;Invert all the bits in rcx.  The result is the number of iterations of the loop
dec        rcx                                  ;Decrement rcx by one in order to avoid counting the null character.
mov        rax, rcx                             ;Copy the count into rax, which is the standard register for returning integers to a caller.

;=========== Restore GPR values and return to the caller ===============================================================

popf                                            ;Restore rflags
pop        r15                                  ;Restore r15
pop        r14                                  ;Restore r14
pop        r13                                  ;Restore r13
pop        r12                                  ;Restore r12
pop        r11                                  ;Restore r11
pop        r10                                  ;Restore r10
pop        r9                                   ;Restore r9
pop        r8                                   ;Restore r8
pop        rdi                                  ;Restore rdi
pop        rsi                                  ;Restore rsi
pop        rdx                                  ;Restore rdx
pop        rcx                                  ;Restore rcx
pop        rbx                                  ;Restore rbx
pop        rbp                                  ;Restore rbp
;Notice that rax is not restored because it holds the value to be returned to the caller.

ret;                                            ;ret will pop the system stack into rip.  The value obtained is an 
;                                               ;address where the next instruction to be executed is stored.
;===== End of subprogram strlen ========================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2
