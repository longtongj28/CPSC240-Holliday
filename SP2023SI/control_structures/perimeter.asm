extern printf
extern scanf
global perimeter

my_constant equ 10

segment .data
welcome db "Welcome to a friendly assembly program by Johnson Tong",10,0
welcome2 db "This program will compute the perimeter and the average side length of a rectangle.", 10, 0

example db "%lf and %lf", 10, 0

one_float_format db "%lf",0
three_float_format db "%lf %lf %lf", 0

four dq 4.0

segment .bss

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

push qword 0
; WRITE YOUR CODE HERE!!!!!

; Ask the user to input a number
; qword -> word 64/4 = 16 bits / 2 bytes

; Input a float
;                  rdi                  rsi          xmm0
; void scanf(string format_string, int* location, double a2)
push qword 0 ; reserves 64 bits / 8 bytes on the top of stack
mov rax, 0 ; number of xmm registers that will be used by next function call
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm15, [rsp]
pop rax

push qword 0 ; reserves 64 bits / 8 bytes on the top of stack
mov rax, 0 ; number of xmm registers that will be used by next function call
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp]
pop rax


push qword 0
mov rax, 2
mov rdi, example
movsd xmm0, xmm15
movsd xmm1, xmm14
call printf
pop rax
; a^2 + b^2 = c^2
; c = sqrt(a^2 + b^2)
; square a
; square b
; add square a + square b
; sqrt
; movsd xmm0

; If the number is negative,
; tell the user to input again
; keep doing until the number is valid
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
