native "hello", hello 
    mov rdi, hello_msg
    call print
    jmp next

native "exit", bye
    mov rax, 60
    xor rdi, rdi
    syscall

native "+", add
    pop rax
    add [rsp], rax
    jmp next

native "-", sub
    pop rax
    sub [rsp], rax
    jmp next

native "*", mul
    pop rax
    pop rdx
    imul rdx
    push rax
    jmp next

native "/", div
    pop rax
    pop rcx
    cqo         ; replica o bit de sinal de RAX em todos os bits de RDX
    idiv rcx
    push rax
    jmp next

native "=", is_equal
    pop rax
    cmp rax, [rsp]
    je .equal

    mov byte [rsp], 0
    jmp next

    .equal:
    mov byte [rsp], 1
    jmp next

native "<", is_less
    pop rax
    cmp rax, [rsp]
    jl .less

    mov byte [rsp], 0
    jmp next

    .less:
    mov byte [rsp], 1
    jmp next

native "not", not
    pop rax
    test rax, rax
    jz .zero

    push 0
    jmp next

    .zero:
    push 1
    jmp next

native "and", and
    pop rax
    pop rdx

    test rax, rax
    jz .false

    test rdx, rdx
    jz .false

    push 1
    jmp next

    .false:
    push 0
    jmp next

native ".", pop
    pop rdi
    call print_int
    call print_newline
    jmp next

native ".S", show_stack
    mov rcx, [stack_base]
    sub rcx, 8

    .loop:
    cmp rcx, rsp
    jb .end 

    mov rdi, [rcx]
    push rcx

    call print_int
    mov rdi, " "
    call print_char

    pop rcx
    sub rcx, 8
    jmp .loop

    .end:
    call print_newline
    jmp next

native "rot", rot
    pop rax
    pop rdx
    pop rcx
    push rdx
    push rax
    push rcx
    jmp next

native "swap", swap
    pop rax
    mov rdx, [rsp]
    mov [rsp], rax
    push rdx
    jmp next

native "dup", dup
    push qword [rsp]
    jmp next

native "drop", drop
    add rsp, 8
    jmp next
