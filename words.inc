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
