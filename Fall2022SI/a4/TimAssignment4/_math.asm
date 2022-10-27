; Copyright 2022 Diamond Dinh (diamondburned), licensed under the MIT license.

%ifndef _math

%use fp

; @cmul(a, b) -> rax
%macro @cmul 2
        mov  rax, %1
        mov  rdi, %2
        imul rdi
%endmacro

; @cdiv(a, b) -> (rax, rdx)
%macro @cdiv 2
        mov  rax, %1                   ; idiv uses this
        mov  rdx, 0                    ; idiv also uses this (for remainder)
        mov  rdi, %2                   ; we use this on our own
        idiv rdi                       ; rax, rdx is implicitly set;
                                       ; div/idiv is very weird
%endmacro

; @cos(rad:xmm?) -> xmm0
%macro @cos 1
        movq  rax, %1                  ; load xmm0 into rax
        push  rax                      ; copy rax onto rsp
        fld   qword [rsp]              ; load rax value in rsp into FPU
        fcos                           ; do the cos()
        fstp  qword [rsp]              ; st0 -> rsp, store st0 into stack
        movsd xmm0, [rsp]              ; load rsp value into xmm0
        add   rsp, 8                   ; unpop rax
%endmacro

; @deg2rad(deg:xmm?) -> xmm0
%macro @deg2rad 1
        movsd xmm0, %1
        mov   rax, float64(0.0174532925199432) ; 180/pi
        movq  xmm1, rax
        mulsd xmm0, xmm1
%endmacro

%endif

