// x0=array, x1=length, x2=48-byte results; calls both helpers for each element.
.text
.global analyze_array
.type analyze_array, %function

analyze_array:
    stp x29, x30, [sp, #-64]!
    stp x19, x20, [sp, #16]
    stp x21, x22, [sp, #32]
    str x23, [sp, #48]
    mov x29, sp

    mov x19, x0 // address of the array
    mov x20, x1 // # of elements
    mov x21, x2 // address where results should be stored

    str xzr, [x21, #0] // Minimum
    str xzr, [x21, #8] // Maximum
    str xzr, [x21, #16] // Sum
    str xzr, [x21, #24] // Positive count
    str xzr, [x21, #32] // Negative count
    str xzr, [x21, #40] // 	Zero count



.size analyze_array, .-analyze_array
.section .note.GNU-stack,"",@progbits
