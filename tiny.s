.globl _start
.text
_start:
    mov $42, %dil
    mov $60, %al
    syscall
