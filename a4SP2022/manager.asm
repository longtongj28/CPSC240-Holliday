extern printf
extern scanf

global manager

segment .data
one_integer_format db "%ld", 0

segment .bss  ;Reserved for uninitialized data
the_array resq 2 ; array of 6 quad words reserved before run time.

segment .text ;Reserved for executing instructions.

manager:

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

push qword 0

push qword 0
mov rax, 0
mov rdi, one_integer_format
mov rsi, rsp
; 844 goes on stack (8 bytes)
call scanf
; pop 8 bytes off into r15 from rsp
pop r15

mov rax, 0
mov rdi, one_integer_format
mov rsi, r15
call printf


; half of it is placed in rax, other half in rdx
; _________________ _________half of the bits_________ rax
; _________________ __________other half goes here________ rdx
; _________half of the bits_________ _________________  rax
; _________________ __________other half goes here________ rdx
; combine those halves and place result in rdx

; get the time in tics (start) r14
cpuid
rdtsc
shl rax, 32
add rdx, rax
mov r14, rdx
;=============

; mov rax, 0
; mov rdi, one_integer_format
; mov rsi, r14
; call printf
mov rax, 0
mov rdi, r15
call compute_sum


; get the time in tics (end) r13
cpuid
rdtsc
shl rax, 32
add rdx, rax
mov r13, rdx
;=============

; end - start, r13 - r14
sub r13, r14
; push qword 0
; mov rax, 0
; mov rdi, the_array
; call get_time_card
; pop rax
pop rax

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


; get_time_card.asm
; the_array - rdi

; compute_wage.cpp

; show_pay_stub.asm