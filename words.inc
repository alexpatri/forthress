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
