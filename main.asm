%include "macros.inc"
%include "utils.inc"

native "teste", test 
    mov rdi, ts
    call print
    jmp exit

section .data
    ts: db "Testando!", 10, 0

section .text
global _start

_start:
    mov rdi, w_test
    call code_from_addr

    jmp rax
