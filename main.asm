%include "macros.inc"
%include "utils.inc"

%define MAX_WORD_SIZE 128

native "hello", hello 
    mov rdi, hello_msg
    call print
    xor rdi, rdi
    jmp exit

native "test", test
    mov rdi, test_msg
    call print
    xor rdi, rdi
    jmp exit

section .data
    test_msg:  db "This is a Test!", 10, 0
    hello_msg: db "Hello, World!", 10, 0
    error_msg: db "No value found for the provided key.", 0
    input_msg: db ">> ", 0

section .bss
    word_input: resb MAX_WORD_SIZE

section .text
global _start

_start:
    mov rdi, input_msg
    call print

    mov rdi, word_input
    mov rsi, MAX_WORD_SIZE
    call read

    mov rdi, word_input
    mov rsi, LAST_NATIVE_ITEM
    call find_word

    test rax, rax
    jz .not_found

    mov rdi, rax
    call code_from_addr

    jmp rax

.not_found:
    mov rdi, error_msg
    call print
    call print_newline

    mov rdi, 1
    jmp exit
