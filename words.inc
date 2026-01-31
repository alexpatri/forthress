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

native "exit", bye
    mov rax, 60
    xor rdi, rdi
    syscall
    
