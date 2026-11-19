// x0=value -> x0=-1/0/1 for negative/zero/positive.
.text
.global classify_value
.type classify_value, %function

classify_value:
    cmp x0, #0
    b.lt negative
    b.gt positive

zero:
    mov x0, #0
    ret

negative:
    mov x0, #-1
    ret

positive:
    mov x0, #1
    ret

.size classify_value, .-classify_value
.section .note.GNU-stack,"",@progbits
