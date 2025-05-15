.section .data

.section .text
.global _start

_start:

    movl   $1, %eax        # System call number for exit
    movl   $0, %ebx        # Exit code 0
    int    $0x80           # Trigger the system call
