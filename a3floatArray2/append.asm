extern printf
extern scanf
global append

segment .data
welcome db "Welcome to a friendly assembly program by Johnson Tong",10,0

one_int_format db "%d",10, 0

segment .bss

segment .text

append: ; RENAME THIS TO THE NAME OF YOUR MODULE/FUNCTION THAT YOU ARE WRITING

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

; func - append(arr1, arr2, arr3, s1, s2)
; returns the total number of elements
mov r15, rdi ; take arr1 from the parameters
mov r14, rsi
mov r13, rdx
mov r12, rcx
mov r11, r8

; write a loop that inputs all of the numbers
; from array 1 into array 3
; loop until we reach r12
mov r10, 0
loop1beg:
    ; xorpd xmm0, xmm0 ; resets a register to 0.0
    cmp r10, r12
    je outLoop1
    ; your code goes here
    ; arr3[i] = arr1[i]
    movsd xmm15, [r15 + 8*r10]
    movsd [r13 + 8*r10], xmm15
    inc r10
    jmp loop1beg
outLoop1:
; write another loop that inputs all of the numbers
; from array 2 into array 3


; optional -> write a single loop that inputs all of the numbers
; from array 1 and array 2 into array 3
mov rax, r10
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
