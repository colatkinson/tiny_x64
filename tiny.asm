BITS 64
GLOBAL _start
SECTION .text
_start:
    mov dil, 42
    mov al, 60
    syscall
