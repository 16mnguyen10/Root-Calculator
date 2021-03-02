;************************************************************************************************************************************
;Program name: "Root Calculator". This program calculates and display the roots (If there are any) of a quadratic                   *
; equation.         Copyright (C) 2021 Michael Nguyen.                                                                              *
;                                                                                                                                   *
;This file is part of the software program "Root Calculator".                                                                       *
;Root Calculator is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License       *
;version 3 as published by the Free Software Foundation.                                                                            *
;Quadratic is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied                    *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.             *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                                    *
;************************************************************************************************************************************




;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
; Author Information
;   Author name: Michael Nguyen
;   Author email: 16mnguyen10@gmail.com
;
; Program Information
;   Program name: Root Calculator
;   Programming Languages: Two modules in C++, one module in X86, one module in C
;   Date program began:       2021-February-18
;   Date program last update: 2021-February-28
;   Date of reorganization of comments: 2021-February-28
;   Files in this program: quadratic.asm isfloat.cpp quad_library.cpp second_degree.c
;   Status: Finished.   The program was tested with no error
;
;This file
;   File name: quadratic.asm
;   Language: X86
;   Assemble: nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm


;===== Begin code area ================================================================================================
extern printf
extern scanf
extern atof
extern isfloat
extern isdigit
extern show_no_root
extern show_one_root
extern show_two_root
global quadratic

; Declaring Constants
null equ 0
newline equ 10

; Initialized data
segment .data

stringoutputformat db "%s", 0
inputmessage db "This program will find the roots of any quadratic equation.", 10, 0
inputmessagetwo db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by the end of line character. ", 10, 0
floatmessage db "%lf", 0
stringmessage db "%s", 0
quadraticformula db "Thank you. The equation %1.6lfx^2 + %1.6lfx + %1.6lf = 0.0", 10, 10, 0
invaliddata db "Invalid input data detected. You may run this program again.", 10, 10, 0
finalmessage db "One of these roots will be returned to the caller function.", 10, 0
threefloatformat db "%lf%lf%lf", 0

; Uninitialized data
segment .bss

; Instruction
segment .text

quadratic:
; Back up
push rbp                                                    ;Backup rbp
mov  rbp,rsp                                                ;The base pointer now points to top of stack
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

; Even out the pushes
push qword -1

;============= Begin section to get three floating point ==============================================================
; Display messages before taking in inputs
push qword 99
mov qword rdi, stringoutputformat
mov rdi, inputmessage               ; This program will find the roots of any quadratic equation.
mov qword rax, 0
call printf
pop rax

; Prompt message
push qword 99
mov qword rdi, stringoutputformat
mov rdi, inputmessagetwo
mov qword rax, 0
call printf
pop rax

; First input
push qword 0
mov rdi, stringmessage
mov rsi, rsp
mov rax, 1
call scanf

; Validation
mov rdi, rsp
mov rax, 0
call isfloat
cmp rax, 0
je invalid

; Converting to a float
mov rax, 1
call atof
movsd xmm10, xmm0
pop rax

; Get Second Input
push qword 0            ; Push qword to make register open
mov rdi, stringmessage  ; Put string format into rdi
mov rsi, rsp            ; Point rsi at rsp
mov rax, 1              ; Put 1 into rax to specify that we want 1 string
call scanf              ; Call scanf

; Validate Second Input
mov rdi, rsp            ; Point  rdi at rsp
mov rax, 0              ; Put 0 into rax to allow a returned bit
call isfloat            ; Call isfloat
cmp rax, 0              ; If rax is 0
je invalid              ; Jump to invalid

; Convert input to float
mov rax, 1              ; Move 1 into rax
call atof               ; call atof
movsd xmm11, xmm0       ; Copy the returned float into xmm10
pop rax                 ; pop rax register

; Get Third Input
push qword 0
mov rdi, stringmessage
mov rsi, rsp
mov rax, 1
call scanf

; Validation
mov rdi, rsp
mov rax, 0
call isfloat
cmp rax, 0
je invalid

; Convert input to float
mov rax, 1
call atof
movsd xmm12, xmm0
pop rax
;============= End section to get three floating point ================================================================


;============= Begin section for calculation ==========================================================================
; Calculate b^2 - 4ac
movsd xmm13, xmm11 ; xmm11 & xmm13 = b || xmm13 will be a copy
mulsd xmm13, xmm13 ; xmm13 = b^2
movsd xmm14, xmm10 ; xmm10 & xmm14 = a
mulsd xmm14, xmm12 ; xmm14 = ac
mov r8, 4          ; Put 4 into r8
cvtsi2sd xmm8, r8  ; Convert 4 into a float and store it in xmm8
mulsd xmm14, xmm8  ; xmm14 = 4ac
subsd xmm13, xmm14 ; xmm13 = b^2 - 4ac
;============= End section for calculation ============================================================================


;============= Begin section to print out equation ====================================================================
push qword 0
mov rax, 3          ; 3 numbers inputted
mov rdi, quadraticformula
movsd xmm0, xmm10
movsd xmm1, xmm11
movsd xmm2, xmm12
call printf
pop rax
; xmm0 and xmm15 is the 1st value, xmm1 and xmm14 is the 2nd value, and xmm3 and xmm13 should be 3rd value
;============= End section to print equation ==========================================================================


;============= Begin section for calculation ==========================================================================
; Calculate b^2 - 4ac
movsd xmm13, xmm11 ; xmm13 = b
mulsd xmm13, xmm13 ; xmm13 = b^2
movsd xmm14, xmm10 ; xmm14 = a
mulsd xmm14, xmm12 ; xmm14 = ac
mov r8, 4          
cvtsi2sd xmm8, r8  
mulsd xmm14, xmm8  ; xmm14 = ac
subsd xmm13, xmm14 ; xmm13 = b^2 - 4ac
;============= End section for calculation ============================================================================


;============= Begin section to find roots ============================================================================
; Finding roots
mov r9, 0          
cvtsi2sd xmm9, r9  
ucomisd xmm13, xmm9     
; If discriminant is 
; less than 0 -> JB, 
; equal to 0 -> JE, 
; more than 0 -> JA 
ja two_roots       
je one_root       
jb no_root         

; No root
no_root:
mov rax, 0
call show_no_root
mov r8, 0
cvtsi2sd xmm14, r8
jmp done

; One root
one_root:
mov r8, -1          
cvtsi2sd xmm8, r8   
mulsd xmm11, xmm8   ; xmm11 = -b
mov r8, 2           
cvtsi2sd xmm8, r8   
mulsd xmm10, xmm8   ; xmm10 = 2a
divsd xmm11, xmm10  ; xmm11 = -b/2a
movsd xmm14, xmm11  ; xmm14 = xmm11 (-b/2a)

; Show_one_root
push qword 0
mov rax, 1          
movsd xmm0, xmm14   ; xmm0 = xmm14
call show_one_root  
pop rax
jmp done       

; Two root
two_roots:
mov r8, -1          
cvtsi2sd xmm8, r8  
mulsd xmm11, xmm8   ; xmm11 = -xmm11
mov r8, 2           
cvtsi2sd xmm8, r8   
mulsd xmm10, xmm8   ; xmm10 = 2a
sqrtsd xmm13, xmm13 ; Sqrt(xmm13)

; First root store in xmm14
movsd xmm14, xmm11  ; xmm14 = 2a
addsd xmm14, xmm13  ; xmm14 = 2a+sqrt(b^2-4ac)
divsd xmm14, xmm10  ; xmm14 = 2a+sqrt(b^2-4ac) / 2a

; Second root goes into xmm15
movsd xmm15, xmm11  ; xmm15 = 2a
subsd xmm15, xmm13  ; xmm15 = 2a-sqrt(b^2 - 4ac)
divsd xmm15, xmm10  ; xmm15 = 2a-sqrt(b^2 - 4ac) / 2a

; Call show_two_root
push qword 0
mov rax, 2
movsd xmm0, xmm14   ; xmm0 = xmm14
movsd xmm1, xmm15   ; xmm1 = xmm15
call show_two_root  
pop rax
;============= End section for finding roots ==========================================================================


done:
; Final message
mov qword rdi, stringoutputformat
mov qword rsi, finalmessage
mov qword rax, 0
call printf
jmp end

invalid:
mov qword rdi, stringoutputformat
mov qword rsi, invaliddata
mov qword rax, 0
call printf
pop rax

;===== Restore original values to integer registers ===================================================================
end:
pop rax                                                     ; Remove the extra -1 from the stack
popf                                                        ; Restore rflags
pop rbx                                                     ; Restore rbx
pop r15                                                     ; Restore r15
pop r14                                                     ; Restore r14
pop r13                                                     ; Restore r13
pop r12                                                     ; Restore r12
pop r11                                                     ; Restore r11
pop r10                                                     ; Restore r10
pop r9                                                      ; Restore r9
pop r8                                                      ; Restore r8
pop rcx                                                     ; Restore rcx
pop rdx                                                     ; Restore rdx
pop rsi                                                     ; Restore rsi
pop rdi                                                     ; Restore rdi
pop rbp                                                     ; Restore rbp

movsd xmm0, xmm14                           
ret                                         
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**