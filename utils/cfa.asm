%define POINTER_SIZE 8
%define FLAGS_OFFSET 2

section .text
global code_from_addr

; rdi recebe o endereço de início de cabeçalho de uma palava
; pula todo o cabeçalho até alcançar o valor de xt
; retorna o valor de xt
code_from_addr:
    add rdi, POINTER_SIZE
    
.find_end:
    cmp byte [rdi], 0
    je .end

    inc rdi
    jmp .find_end

.end:
    add rdi, FLAGS_OFFSET

    mov rax, rdi
    ret
