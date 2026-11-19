// Analyze demo_array using demo_length; store demo_results; return 0.
.text
.global main
.type main, %function

// x0 = adress of demo_array
// x1 = length of array
// x2 = address of demo_results
main:

    // Saves the original return addresses because other methods use it
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    ldr x0, =demo_array // stores address of array

    ldr x1, =demo_length // stores the address of the demo_length into x1
    ldr x1, [x1] // stores the actual value of demo_length into x1

    ldr x2, =demo_results // stores address of demo_results into x2

    bl analyze_array

    mov x0, #0 // returns 0 when the program finishes

    ldp x29, x30, [sp], #16 // restores the original return address
    ret


.size main, .-main
.section .note.GNU-stack,"",@progbits

.data
.balign 8
.global demo_array, demo_length
demo_array: .quad -4, 0, 7, -2, 7, 0
demo_length: .quad 6
.bss
.balign 8
.global demo_results
demo_results: .skip 48
