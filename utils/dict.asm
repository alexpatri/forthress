%define ITEM_NAME 8

section .text
global find_word

extern string_equals
extern strlen

; rdi recebe uma string termindada com núlo como chave
; rsi recebe um ponteiro para a última palavra do dicionário
;
; percorre o dicionário buscando pelo registro referente a chave informada
;   devolve zero caso não encontre
;   devolve o endereço do registro caso encontre
find_word:
    ; ponteiro para a chave a ser buscada
    mov r10, rdi

    ; calcula tamanho da chave
    ; offset para o endereço do valor
    mov rdi, r10
    call strlen
    mov r11, rax
    inc r11

.loop:
    ; ponteiro para o próximo item
    mov r8, [rsi]

    ; ponteiro para a chava
    lea r9, [rsi + ITEM_NAME]

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
    lea rax, [r9 + r11]
    ret

.not_found:
    xor rax, rax
    ret
