extern printf
extern scanf
extern isFloat
extern atof

global compare

segment .data
input_prompt db "Please enter two float numbers separated by white space. Press enter after the second input.", 10, 0
two_string_format db "%s %s", 0
bad_message db "bad float", 10, 0
two_float_format db "Your numbers are %.16lf and %.16lf", 10, 0
one_float_format db "C is %.16lf", 10, 0
segment .bss

segment .text

compare:
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
                                                       ;Backup rflags                                         
; print input prompt
mov rax, 0
mov rdi, input_prompt
call printf

;take in 2 strings
sub rsp, 2048 ; make space for 2 strings
mov rax, 0
; scanf needs the 2 strings' locations
mov rdi, two_string_format
mov rsi, rsp
mov rdx, rsp
add rdx, 1024
; save the addresses of the string locations on the stack
mov r15, rsp
mov r14, rdx
call scanf
pop r15
pop r14
;====================
; if you want to try to do scanf in individual blocks.
; push qword 0
; mov rax, 0
; mov rdi, single_formatter
; mov rsi, rsp
; call scanf
; movsd xmm10, [rsp]
; pop rax

; push qword 0
; mov rax, 0
; mov rdi, single_formatter
; mov rsi, rsp
; call scanf
; mov r14, [rsp]
; pop rax

; putting zero into xmms
; mov rax, 0
; cvtsi2sd xmm5, rax

; movsd xmm0, 0x0000000000000000

; ;"Fast zero"
; xorpd xmm7, xmm7
; ; OR statements
; ; True || False = True
; ; False || True = True
; ; TRUE || TRUE = True
; ; XOR
; ; True || False = True
; ; False || True = True
; ; TRUE || TRUE = False
; ; FALSE || FALSE = False
; ucomisd xmm6, xmm7
; jle BadMessage

;check if first string is bad input
mov rax, 0
mov rdi, r15
call isFloat
cmp rax, 0
je BadMessage

; validate second float
mov rax, 0
mov rdi, r14
call isFloat
cmp rax, 0
je BadMessage

mov rax, 0
mov rdi, r14
call atof
movsd xmm14, xmm0

;is a float, convert to float (first float)
mov rax, 0
mov rdi, r15
call atof
movsd xmm15, xmm0

; a^2 + b^2 = c^2
; c = sqrt(a^2 + b^2)
; c = sqrt(a*a + b*b)
; xmm14 - a, xmm15 - b
movsd xmm13, xmm14
mulsd xmm13, xmm13

movsd xmm12, xmm15
mulsd xmm12, xmm12

addsd xmm12, xmm13
sqrtsd xmm12, xmm12

mov rax, 1
mov rdi, one_float_format
movsd xmm0, xmm12
call printf

; Putting 1/2 into xmms
; movsd xmm0, 0x7FFF1ABC

; mov rax, 1
; cvtsi2sd xmm10, rax

; mov rax, 2
; cvtsi2sd xmm9, rax

; divsd xmm10, xmm9

; print out the 2 nums, this is seg faulting for some reason, figure out if u can
mov rax, 2
mov rdi, two_float_format
movsd xmm0, xmm15
movsd xmm1, xmm14
call printf

; TODO: print out the larger float
; TODO: return the smaller float to the driver
; TODO: return -1 to the driver if the user provides invalid floats.

jmp end

BadMessage:
mov rax, 0
mov rdi, bad_message
call printf
;print "bad"
end:
add rsp, 2048

; returning floats should go in xmm0, non-floats in rax.
; below is a way to "fast-zero" an xmm register.
xorpd xmm0, xmm0
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
