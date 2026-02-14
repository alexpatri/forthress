native "hello", hello 
    mov rdi, hello_msg
    jmp print
    call print_newline
    jmp next

native "exit", bye
    mov rax, 60
    xor rdi, rdi
    syscall

native "+", add
    pop rax
    add [rsp], rax
    jmp next

native ".", pop
    pop rdi
    call print_int
    call print_newline
    jmp next
