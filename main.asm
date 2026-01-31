%include "macros.inc"
%include "utils.inc"
%include "words.inc"

%define MAX_WORD_SIZE 255

section .data
    test_msg:  db "This is a Test!", 10, 0
    hello_msg: db "Hello, World!", 10, 0
    error_msg: db "The provided word does not exist.", 0
    input_msg: db ">> ", 0

section .bss
    word_input: resb MAX_WORD_SIZE

section .text
global _start

_start:
    mov rdi, input_msg
    call print

    mov rdi, word_input
    call read_word

    cmp rax, 0
    jz .exit

    mov rdi, rax 
    mov rsi, LAST_WORD
    call find_word

    test rax, rax
    jz .not_found

    mov rdi, rax
    call code_from_addr

    jmp rax

.exit:
    xor rax, rax
    jmp exit

.not_found:
    mov rdi, error_msg
    call print
    call print_newline

    mov rdi, 1
    jmp exit
