extern printf
extern scanf
extern qsort
extern compar
global perimeter

segment .data
welcome db "Welcome to a friendly assembly program by Johnson Tong",10,0
welcome2 db "This program will compute the perimeter and the average side length of a rectangle.", 10, 0

one_float_format db "%lf",0
three_float_format db "%lf %lf %lf", 0

four dq 4.0

segment .bss
array1: resq 12

segment .text

perimeter: ; RENAME THIS TO THE NAME OF YOUR MODULE/FUNCTION THAT YOU ARE WRITING

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

; If this "module" is a function,
; save the parameters here (rdi, rsi, rdx, rcx, r8, r9) (xmm0, xmm1,...)

; To generate 6 random qwords
; for i = 0 until 6, inc:
;   generate random number
;   arr[i] = random num
;   store the random number in array

mov r15, 0
beginLoop:
    cmp r15, 6
    je exitLoop

    rdrand r12   ;generate qword

    mov rbx, r12
    ; Check for isNan
    shr rbx, 52 ; (shift r12 to the right by the size of the mantissa)
    ; if r12 == 7FF (pos nan) or r12 == FFF (neg nan)
    cmp rbx, 0x7FF ; check if pos nan
    je beginLoop
    cmp rbx, 0xFFF ; check if neg nan
    je beginLoop

    mov [array1 + 8*r15], r12; Store that qword in array1

    inc r15
    jmp beginLoop
exitLoop:
    
; void qsort(void *base, size_t nitems, size_t size, int (*compar)(const void *, const void*))
; Sorting array 1
mov rdi, array1
mov rsi, 6
mov rdx, 8
mov rcx, compar
call qsort

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
