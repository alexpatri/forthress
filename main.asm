%include "macros.inc"
%include "utils.inc"
%include "words.inc"

%define MAX_WORD_SIZE 255

%define pc r15

section .data
    hello_msg: db "Hello, World!", 10, 0
    error_msg: db "The provided word does not exist.", 0
    ; input_msg: db ">> ", 0

    stack_base: dq 0

section .bss
    word_input: resb MAX_WORD_SIZE

section .text
global _start

next:
    jmp pc

_start:
    mov pc, .loop
    mov [stack_base], rsp

.loop:
    ; mov rdi, input_msg
    ; call print

    mov rdi, word_input
    call read_word

    cmp rax, 0
    jz .exit

    mov rdi, rax 
    mov rsi, LAST_WORD
    call find_word

    test rax, rax
    jz .number

    mov rdi, rax
    call code_from_addr

    jmp rax

.number:
    mov rdi, word_input
    call parse_int
    test rdx, rdx
    jz .not_found

    push rax
    jmp .loop

.exit:
    xor rdi, rdi
    jmp exit

.not_found:
    mov rdi, error_msg
    call print
    call print_newline

    jmp .loop
