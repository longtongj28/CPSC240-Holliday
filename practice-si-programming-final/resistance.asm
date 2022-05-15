;Johnson Tong
;CPSC 240-1 Test 1

extern printf
extern scanf
extern compute
extern fill

global resistance

segment .data

inputprompt db "Enter the resistance numbers of the two subcircuits separated by ws and press enter: ",0

three_float_format db "%lf%lf%lf",0

outputResistances db "These resistances were received: %.15lf Ω, %.15lf Ω, %.15lf Ω.",10,0
outputTotalR db "The resistance of the entire circuit is %.15lf Ω.", 10, 0

goodbye db "The total resistance will be returned to the caller module.",10,0

one dq 1.0

segment .bss
array resq 3

segment .text

resistance:
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
;=========begin inputs for the 3 resistances===================
push qword 0
;Display a prompt message asking for the inputs
mov rax, 0
mov rdi, inputprompt         ;"Enter the resistance numbers of the two subcircuits separated by ws and press enter: "
call printf
pop rax

; void fill(array)
mov rdi, array
call fill

;Input the 3 resistances
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
; for int i = 0, i < 3, i++
; =============End input of 3 resistances===========

; ========== output the 3 resistances received =======
push qword 0
mov rax, 3
mov rdi, outputResistances        ;"These resistances were received %.15lf, %.15lf, %.15lf..."
movsd xmm0, [array]
movsd xmm1, [array + 8]
movsd xmm2, [array + 16]
call printf
pop rax

; double compute(array) -> xmm0
mov rdi, array
call compute
movsd xmm11, xmm0
; ===========End output of 3 resistances==========

; =====Time to calculate the total resistance=======
; 1/r = 1/R1 + 1/R2 + 1/R3
; r = 1/(1/R1 + 1/R2 + 1/R3)
; first we need to add the resistances (each divided by 1.0)
; one declared in segment.data
; movsd xmm8, [one]
; movsd xmm9, [one]
; movsd xmm10, [one]
; ; doing 1/R1, 1/R2, 1/R3 and adding them, registers xmm5-7 contain our resistances
; divsd xmm8, xmm5
; divsd xmm9, xmm6
; divsd xmm10, xmm7
; ; adding them together, total will now be stored in xmm8
; addsd xmm8, xmm9
; addsd xmm8, xmm10
; ; doing 1/rTotal (stored in xmm11)
; movsd xmm11, [one]
; divsd xmm11, xmm8
; ============End of calculations==============

; =========== Output total resistance ===========
push qword 0
mov rax, 1
mov rdi, outputTotalR
movsd xmm0, xmm11
call printf
pop rax
; ========== end output total resistance =========

; =========== goodbyes ===============
push qword 0
mov rax, 0
mov rdi, goodbye
call printf
pop rax
; =========== really goodbye now ============

pop rax     ;counteract push at beginning of code

movsd xmm0, xmm11
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