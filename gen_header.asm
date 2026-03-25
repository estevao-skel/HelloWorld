section .data
    outfile     db "src/helloworld.h", 0
    header_text db "#ifndef HELLOWORLD_H", 10
                db "#define HELLOWORLD_H", 10
                db "#ifdef __cplusplus", 10
                db 'extern "C" {', 10
                db "#endif", 10
                db "int HelloWorld(const char *command);", 10
                db "int helloworld(const char *command);", 10
                db "int hello_world(const char *command);", 10
                db "#ifdef __cplusplus", 10
                db "}", 10
                db "#endif", 10
                db "#endif", 10
    header_len  equ $ - header_text

section .text
    global _start

_start:
    mov     eax, 2
    lea     rdi, [rel outfile]
    mov     esi, 577
    mov     edx, 0o644
    syscall
    test    rax, rax
    js      .fail
    mov     r12, rax
    mov     eax, 1
    mov     rdi, r12
    lea     rsi, [rel header_text]
    mov     edx, header_len
    syscall
    mov     eax, 3
    mov     rdi, r12
    syscall
    mov     eax, 60
    xor     edi, edi
    syscall
.fail:
    mov     eax, 60
    mov     edi, 1
    syscall
