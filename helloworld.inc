%define HELLOWORLD_OK      0
%define HELLOWORLD_EINVAL -1
%define HELLOWORLD_PRINT  "print"

%macro HELLOWORLD_CALL 0
jmp     %%skip
%%cmd: db "print", 0
%%skip:
lea     rdi, [rel %%cmd]
call    HelloWorld
%endmacro
