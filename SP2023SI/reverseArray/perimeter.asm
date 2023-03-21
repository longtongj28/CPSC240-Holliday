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

array1 dq 5.0, 2.5, 2.6, 5.2, 6.2

segment .bss
array2: resq 5

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

; array1 and array2 of the same size
; pointer a (starts from the end of array1)
; decrement a while traversing

; array1 - pointer a = 5
; 0 1 2 3 4 5
; arrar2 - result array - pointer b = 0
; 0 1 2 3 4 5

; a = 5
; b = 0
; for a = 5, a < 0, a--;b++:
;     array2[b] = array1[a]

mov r15, 4
mov r14, 0
beginLoop:
    cmp r15, 0
    jl endLoop

    movsd xmm15, [array1 + 8*r15]
    movsd [array2 + 8*r14], xmm15

    dec r15
    inc r14
    jmp beginLoop
endLoop:


; func manager():
;     array1 = 1 2 3;
;     perimeter(array1);

; func perimeter(array1):
;    array1 = 3 4 5
;    return array1
;
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
