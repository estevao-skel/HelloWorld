section .data
    msg     db "Hello World", 10
    msg_len equ $ - msg
    cmd     db "print", 0

section .text

global HelloWorld
global helloworld
global hello_world

%ifidn __OUTPUT_FORMAT__, win64

extern  GetStdHandle
extern  WriteFile

%define FRAME 48

HelloWorld:
helloworld:
hello_world:
    push    rbp
    mov     rbp, rsp
    sub     rsp, FRAME
    mov     r12, rcx
    test    r12, r12
    jz      .fail
    lea     rax, [rel cmd]
    mov     edx, dword [r12]
    cmp     edx, dword [rax]
    jne     .fail
    mov     dx,  word [r12+4]
    cmp     dx,  word [rax+4]
    jne     .fail
    mov     ecx, -11
    call    GetStdHandle
    mov     rcx, rax
    lea     rdx, [rel msg]
    mov     r8d, msg_len
    lea     r9,  [rbp-8]
    push    0
    call    WriteFile
    add     rsp, 8
    xor     eax, eax
    jmp     .done
.fail:
    or      eax, -1
.done:
    add     rsp, FRAME
    pop     rbp
    ret

%else

HelloWorld:
helloworld:
hello_world:
    test    rdi, rdi
    jz      .fail
    lea     rax, [rel cmd]
    mov     edx, dword [rdi]
    cmp     edx, dword [rax]
    jne     .fail
    mov     dx,  word [rdi+4]
    cmp     dx,  word [rax+4]
    jne     .fail
    mov     eax, 1
    mov     edi, 1
    lea     rsi, [rel msg]
    mov     edx, msg_len
    syscall
    xor     eax, eax
    ret
.fail:
    or      eax, -1
    ret

%endif

section .note.GNU-stack noalloc noexec nowrite progbits
