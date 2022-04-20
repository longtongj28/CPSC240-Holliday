extern printf
extern scanf
extern outputoneline

global compute_sum

segment .data
one_integer_format db "%ld", 0
one_float_format db "%.10lf", 10, 0

segment .bss  ;Reserved for uninitialized data
the_array resq 2 ; array of 6 quad words reserved before run time.

segment .text ;Reserved for executing instructions.

compute_sum:

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

mov r15, rdi ; taking user n from parameter rdi

push qword 0

xorpd xmm15, xmm15 ; sum = 0

; 1.0 in xmm14
mov rax, 1
cvtsi2sd xmm14, rax

mov r14, 1 ; i = 1
begin_loop:
; float 1 / i
; 1 to a float and i to a float
cvtsi2sd xmm13, r14
movsd xmm12, xmm14 ; save the 1.0 in xmm14, by making a copy
divsd xmm12, xmm13

addsd xmm15, xmm12

mov rax, 1
mov rdi, r14
movsd xmm0, xmm15
mov rsi, r15
call outputoneline

inc r14
; n = 5
; i = 4 + 1 = 5 + 1
cmp r14, r15
jg end_loop

jmp begin_loop

end_loop:
; print term# sum

; mov rax, 1
; mov rdi, one_float_format
; movsd xmm0, xmm15
; call printf

pop rax
movsd xmm0, xmm15
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