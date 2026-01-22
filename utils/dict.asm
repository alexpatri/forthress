%define POINTER_SIZE 8

section .text
global find_word

extern string_equals

; rdi recebe uma string termindada com núlo como chave
; rsi recebe um ponteiro para a última palavra do dicionário
;
; percorre o dicionário buscando pela palavra informada
;   devolve zero caso não encontre
;   devolve o endereço do cabeçalho da palavra caso encontre
find_word:
    ; ponteiro para a chave a ser buscada
    mov r10, rdi

.loop:
    ; ponteiro para o item atual 
    mov r11, rsi

    ; ponteiro para o próximo item
    mov r8, [rsi]

    ; ponteiro para a chava
    lea r9, [rsi + POINTER_SIZE]

    ; compara a chave informada com a chave do item da lista
    mov rdi, r10
    mov rsi, r9
    call string_equals

    ; 1 = iguais
    ; 0 = diferentes
    cmp rax, 1
    je .found

    ; ponteiro para o próximo item igual a 0 significa o fim da lista
    cmp r8, 0
    je .not_found

    mov rsi, r8
    jmp .loop

.found:
    mov rax, r11
    ret

.not_found:
    xor rax, rax
    ret
