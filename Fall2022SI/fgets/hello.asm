; Copyright 2021 Daniel Cazarez
; This program is free software, you can redistribute it and or modify it
; under the terms of the GNU General Public License version 3
; A copy of the GNU General Public License version 3 is available here: https://www.gnu.org/licenses/

; Author Name: Daniel Cazarez
; Author Email: danielcaz2200@csu.fullerton.edu

; Program name: Assembly Welcome Program, v2.0
; Files in program: welcome.cpp, hello.asm, r.sh
; System requirements: Linux on an x86 machine
; Programming languages: x86 Assembly, C++ and BASH
; Date program development began: Aug 20, 2021
; Date finished: Sept 1, 2021
; Status: No known errors

; Purpose: This program prompts the user for input and then repeats the input back to the user
; This program will return the user's name back to the C++ driver program. String I/O testing.

; File name: hello.asm
; Language: x86 Assembly
; No data passed to this module. Module passes string back to C++.

; Translation information
; Compile this file: nasm -f elf64 -l hello.lis -o hello.o hello.asm
; Link the two files: g++ -m64 -fno-pie -no-pie -std=c++17 -o good.out good_morning.o hello.o
; ./good.out is the executable

; "Johnson Tong \n"
; Declare external C++ functions & make funct 'hello' visible to other languages & create constant
extern printf

extern scanf

extern fgets

extern stdin

extern strlen

INPUT_LEN equ 256 ; Max bytes of name, title, response
LARGE_BOUNDARY equ 64
SMALL_BOUNDARY equ 16

global hello

segment .data

; Align next data items on 16-byte boundary, every data item will be separated by 16 bytes
align SMALL_BOUNDARY

  format: db "%s", 0 ; Format indicating a null-terminated string, c-string

  ; === Messages to be printed to user ===
  message1:  db        "Please enter your first and last name: ", 0   ; newline would be 10 normally
  message2:  db        "Please enter your title (Ms, Mr, Engineer, Programmer, Mathematician, Genius, etc): ", 0
  message3:  db        "Hello ", 0
  spc: db " ", 0 ; space character
  message4: db ". How is your day so far? ", 0
  message5: db " is great.", 10, 0
  exit: db "This concludes the demonstration of the Hello program written in x86 assembly.", 10, 0

; Align next data items on 64-byte boundary, every data item will be separated by 64 bytes
align LARGE_BOUNDARY

segment .bss
  ; === Reserve bytes for the title, name, and response given by user ===
  ; Reserve 256 bytes for each
  title: resb INPUT_LEN
  name: resb INPUT_LEN
  response: resb INPUT_LEN

segment .text

; Entry point of program
hello:
  push rbp ; Push memory address of base of previous stack frame onto stack top
  mov rbp, rsp ; Copy value of stack pointer into base pointer, rbp = rsp = both point to stack top
  ; Rbp now holds the address of the new stack frame, i.e "top" of stack
  push rdi ; Backup rdi
  push rsi ; Backup rsi
  push rdx ; Backup rdx
  push rcx ; Backup rcx
  push r8 ; Backup r8
  push r9 ; Backup r9
  push r10 ; Backup r10
  push r11 ; Backup r11
  push r12 ; Backup r12
  push r13 ; Backup r13
  push r14 ; Backup r14
  push r15 ; Backup r15
  push rbx ; Backup rbx
  pushf ; Backup rflags

  ; Mov rax, 0 = move 0 into rax, i.e rax = 0.
  ; 0 indicates we will not have any floating pt arguments, so 0 XMM registers used
  mov rax, 0

  ; Move message format (1st parameter) into
  ; general purpose register rdi, indicating the correct format
  ; Formats output to indicate null-terminated string
  ; Passes parameter to printf
  mov rdi, format

  ; Move message to print to general purpose register rsi
  ; Passes parameter to printf
  mov rsi, message1

  ; Call external C++ print funct
  call printf

  ; === old style ===
  ;mov rax, 0

  ; similar to before, but now we pass parameters to scanf
  ;mov rdi, format
  ;mov rsi, name

  ; call external C++ input function
  ;call scanf
  ; === old style ===

  ; Indicate we have no floating point arguments to pass to external function
  mov rax, 0

  ; Move first argument into argument register rdi
  mov rdi, name

  ; Provide fgets with the second argument, the size of the bytes reserved
  ; Move into second argument register rsi
  mov rsi, INPUT_LEN ; read 256 bytes

  ; Move the contents at address of stdin, i.e. dereference, into 3rd argument
  ; register
  mov rdx, [stdin]

  ; Call the external function fgets
  call fgets

  ; Remove newline char from fgets input
  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, name ; Move name into the first argument register
  call strlen ; Call external function strlen, which returns the length of the string leading up to '\0'
  
  sub rax, 1 ; The length is stored in rax. Here we subtract 1 from rax to obtain the location of '\n'
  mov byte [name + rax], 0 ; Replace the byte where '\n' exits with '\0'

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, message2 ; Move message2 into second argument register rsi
  call printf ; Call external function printf

  mov rax, 0 ; Indicate we have no floating point arguments to pass to external function
  mov rdi, title ; Move first argument into argument register rdi
  mov rsi, INPUT_LEN ; Provide fgets with the second argument, the size of the bytes reserved, then move it into second argument register rsi
  mov rdx, [stdin] ; Move the contents at address of stdin, i.e. dereference, into 3rd argument register
  call fgets ; Call the external function fgets

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, title ; Move title into the first argument register
  call strlen ; Call external function strlen, which returns the length of the string leading up to '\0'
  sub rax, 1 ; The length is stored in rax. Here we subtract 1 from rax to obtain the location of '\n'
  mov byte [title + rax], 0 ; Replace the byte where '\n' exits with '\0'


  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, message3 ; Move message3 into second argument register rsi
  call printf ; Call external function printf

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, title ; Move title into second argument register rsi
  call printf ; Call external function printf

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, spc ; Move space character to format output into second argument register rsi
  call printf ; Call external function printf

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, name ; Move name into second argument register rsi
  call printf ; Call external function printf

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, message4 ; Move message4 into second argument register rsi
  call printf ; Call external function printf

  mov rax, 0 ; Indicate we have no floating point arguments to pass to external function
  mov rdi, response ; Move first argument into argument register rdi
  mov rsi, INPUT_LEN ; Provide fgets with the second argument, the size of the bytes reserved, move into second argument register rsi
  mov rdx, [stdin] ; Move the contents at address of stdin, i.e. dereference, into 3rd argument register
  call fgets ; Call the external function fgets

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, response ; Move response into the first argument register
  call strlen ; Call external function strlen, which returns the length of the string leading up to '\0'
  sub rax, 1 ; The length is stored in rax. Here we subtract 1 from rax to obtain the location of '\n'
  mov byte [response + rax], 0 ; Replace the byte where '\n' exits with '\0'

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, response ; Move the user's response (with actual response) into second argument register rsi
  call printf ; Call external function printf

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, message5 ; Move message5 into second argument register rsi
  call printf ; Call external function printf

  mov rax, 0 ; Indicate 0 floating point arguments
  mov rdi, format ; Move string format argument into register rdi
  mov rsi, exit ; Move the final message, which declares the end of the Hello module, into rsi
  call printf ; Call external function printf

  ; Move name into rax general purpose register
  ; which is used to return values to the calling function
  ; Here a copy of the starting address of the char array
  ; will be returned
  mov rax, name

  popf ; Restore rflags
  pop rbx ; Restore rbx
  pop r15 ; Restore r15
  pop r14 ; Restore r14
  pop r13 ; Restore r13
  pop r12 ; Restore r12
  pop r11 ; Restore r11
  pop r10 ; Restore r10
  pop r9 ; Restore r9
  pop r8 ; Restore r8
  pop rcx ; Restore rcx
  pop rdx ; Restore rdx
  pop rsi ; Restore rsi
  pop rdi ; Restore rdi


  pop rbp ; Restore rbp

  ret
