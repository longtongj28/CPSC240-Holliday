;Johnson Tong

;CPSC 240-1 Test 1
extern scanf
global fill

segment .data
single_float_format db "%.15lf", 0

segment .bss
array resq 3

segment .text

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
pushf   

mov r8, rdi
; for int i = 0, i < 3, i++
;   array[i] = scanf()
;   scanf(single_float_format, array[i])
;                 %.15lf ,  i want to place here
mov r15, 0
beginLoop:
    cmp r15, 3
    je endLoop

    push qword 0
    mov rax, 0
    mov rdi, single_float_format
    mov rsi, [r8 + 8*r15];array[i]
    call scanf
    inc r15
    pop rax
    ; when r15 == 3

    
    jmp beginLoop
endLoop:
; push qword -1
; push qword -2
; push qword -3
; mov rax, 0
; mov rdi, three_float_format
; mov rsi, array
; mov rdx, array
; add rdx, 8
; mov rcx, array
; add rcx, 16
; call scanf
; ; movsd xmm5, [rsp]
; ; movsd xmm6, [rsp + 8]
; ; movsd xmm7, [rsp + 16]
; pop rax
; pop rax
; pop rax

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