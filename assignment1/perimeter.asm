extern printf
extern scanf
global floatio

segment .data
welcome db "Welcome to a friendly assembly program by Johnson Tong",10,0
welcome2 db "This program will compute the perimeter and the average side length of a rectangle.", 10, 0

input1prompt db "Enter the height: ",0
input2prompt db "Enter the width", 0

one_float_format db "%lf",0

output_perimeter_float db "The perimeter is %.1lf.",10,0
output_average_float db "The length of the average side is %.3lf", 10, 0

goodbye db "I hope you enjoyed your rectangle",10,0
goodbye2 db "The assembly program will send the perimeter to the main function.", 10,0
goodbye3 db "A 0 will be returned to the operating system.", 10,0
goodbye4 db "Have a nice day.",10,0

segment .bss

segment .text

rectangle: 
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

;Registers rax, rip, and rsp are usually not backed up.
push qword 0

; Display the welcome messages
mov rax, 0                  ;printf uses no data from xmm registers
mov rdi, welcome            ;"Welcome to a friendly assembly program by Johnson Tong"
call printf

mov rax, 0
mov rdi, welcome2
call printf