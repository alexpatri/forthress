%include "macros.inc"
%include "utils.inc"

%define MAX_WORD_SIZE 255

%define pc r15
%define w r14
%define rstack r13

section .data
    hello_msg: db "Hello, World!", 10, 0
    error_msg: db "The provided word does not exist.", 0

    stack_base: dq 0

    ; program_stub é dividido em duas partes
    ; primeiro um espaço vazio para um xt (onde fica armazenado o xt da palavra lida em stdin)
    ; sedundo o xt do interpretador (é dessa forma que é feito o loop em next)
    program_stub: dq 0
    xt_interpreter: dq .interpreter
    .interpreter: dq interpreter_loop

section .bss
    ; pilha para 'colon'
    resq 1023
    rstack_start: resq 1

    word_input: resb MAX_WORD_SIZE

%include "words.inc"

section .text
global _start

; quando é lido uma palavra:
; pc contem o mesmo que program_stub
; ou seja o primeiro elemento é o xt da palavra a ser executada e o segundo é o xt do interpreter
; quando se soma 8 pc passa a conter, no primeiro elemento o xt do interpreter
;
; quando next vem de uma palavra:
; pc contem xt do interpreter, dessa forma o `jump [w]` pula para o interpreter
;
; é dessa forma que funciona o loop do interpretador
next:
    mov w, [pc]
    add pc, 8
    jmp [w]

_start:
    mov rstack, rstack_start
    mov [stack_base], rsp

interpreter_loop:
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

    ; move o xt da palavra lida para program_stub
    ; move program_stub para pc e pula para next
    mov [program_stub], rax
    mov pc, program_stub
    jmp next

.number:
    mov rdi, word_input
    call parse_int
    test rdx, rdx
    jz .not_found

    push rax
    jmp interpreter_loop

.exit:
    xor rdi, rdi
    jmp exit

.not_found:
    mov rdi, error_msg
    call print
    call print_newline

    jmp interpreter_loop
