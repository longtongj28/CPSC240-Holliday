global compute
segment .data
one dq 1.0

segment .bss

segment .text

compute:

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

mov r15, rdi

movsd xmm8, [one]
movsd xmm9, [one]
movsd xmm10, [one]
; =====Time to calculate the total resistance=======
; 1/r = 1/R1 + 1/R2 + 1/R3
; r = 1/(1/R1 + 1/R2 + 1/R3)
; doing 1/R1, 1/R2, 1/R3 and adding them, registers xmm5-7 contain our resistances
divsd xmm8, [r15]
divsd xmm9, [r15+8]
divsd xmm10, [r15+16]
; adding them together, total will now be stored in xmm8
addsd xmm8, xmm9
addsd xmm8, xmm10
; doing 1/rTotal (stored in xmm11)
movsd xmm11, [one]
divsd xmm11, xmm8


movsd xmm0, xmm11

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