;**********************************************************************************************************************
;Function name: "Get Frequency".  This software function extract the published frequency of processor running the     *
;processor executing the function.  Copyright (C) 2021 Floyd Holliday                                                 *
;                                                                                                                     *
;Get Frequency is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General   *
;Public License, version 3, as published by the Free Software Foundation.                                             *
;Get Frequency is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied  * 
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more *
;details.  You should have received a copy of the GNU Lesser General Public License along with Get Frequency.  If not *
;see <https://www.gnu.org/licenses/>.                                                                                 *
;**********************************************************************************************************************

;Copyright holder information
;Author: Floyd Holliday
;Contact: holliday@fullerton.edu

;Library function information
;Library function name: Get Frequency
;Language: X86-64 with Intel syntax
;Date development began: 2020-Sept-02
;Date of latest update:  2021-Nov-12
;File name getfrequency.asm
;Prototype:  double getfreq()
;Status: Beta, available for public comment.

;Purpose: Extract the CPU maximum published speed from the processor

;Translation: nasm -f elf64 -o freq.o getfrequency.asm
;======================================================================================================================

;Declaration area
global getfreq

extern atof

segment .data
   ;Empty

segment .bss
   ;Empty

segment .text
getfreq:

;Prolog: Back up the GPRs
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf


;Extract data from processor in the form of two 4-byte strings
mov rax, 0x0000000080000004
cpuid
;Answer is in ebx:eax as big endian strings using the standard ordering of bits.
mov       r15, rbx      ;Second part of string saved in r15
mov       r14, rax      ;First part of string saved in r14


;Catenate the two short strings into one 8-byte string in big endian
and r15, 0x00000000000000FF    ;Convert non-numeric chars to nulls
shl r15, 32
or r15, r14                    ;Combined string is in r15

;Use of mask: The number 0x00000000000000FF is a mask.  
;In general masks are used to change some bits to 0 (or 1) and leave others unchanged.


;Convert string now stored in r15 to an equivalent IEEE numeric quadword.
push r15
mov rax,0          ;The value in rax is the number of xmm registers passed to atof, 
mov rdi,rsp        ;rdi now points to the start of the 8-byte string.
call atof          ;The number is now in xmm0
pop rax


;Epilogue: restore data to the values held before this function was called.
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp               ;Restore the base pointer of the stack frame of the caller.
ret

ret
