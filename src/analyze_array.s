// x0=array, x1=length, x2=48-byte results; calls both helpers for each element.
.text
.global analyze_array
.type analyze_array, %function


analyze_array:

    // saving the registers and the return addresses
    stp x29, x30, [sp, #-64]!
    stp x19, x20, [sp, #16]
    stp x21, x22, [sp, #32]
    str x23, [sp, #48]
    mov x29, sp

    // saving the arguments in other registers so the origininal ones do get written over
    mov x19, x0 // address of the array
    mov x20, x1 // # of elements
    mov x21, x2 // address where results should be stored

    // initializing the memory address
    str xzr, [x21, #0] // Minimum
    str xzr, [x21, #8] // Maximum
    str xzr, [x21, #16] // Sum
    str xzr, [x21, #24] // Positive count
    str xzr, [x21, #32] // Negative count
    str xzr, [x21, #40] // 	Zero count

    // if array is empty
    cmp x20, #0
    b.eq done

    // initializing the registers for when we eventually get the min and max
    ldr x23, [x19] // loads first element of array into x23
    str x23, [x21, #0]
    str x23, [x21, #8]

    // Initialize the index for the loop
    mov x22, #0

loop:

    // checks whether we have reached the end of the array
    cmp x22, x20
    b.hs done // branch higher or the same

    // Load current array element
    // lsl #3 mulitiplies index by 8 because there are 64 bytes (logical shift left)
    ldr x23, [x19, x22, lsl #3]

    // Add current value to sum
    ldr x9, [x21, #16]
    add x9, x9, x23
    str x9, [x21, #16]

    // Classify current value
    mov x0, x23
    bl classify_value

    // Determine which count to update so we know if the value is positive or negative
    cmp x0, #0
    b.gt positive
    b.lt negative

    // if it wasnt "1" or "-1" then move onto this step where we initialize
    // and increment the 0 counter
    ldr x9, [x21, #40] // initializing
    add x9, x9, #1
    str x9, [x21, #40]
    b update_extrema

positive:
    // Positive count
    ldr x9, [x21, #24]
    add x9, x9, #1
    str x9, [x21, #24] // stores the value in x9 into memory at the address held in x21 plus 24 bytes.
    b update_extrema

negative:
    // Negative count
    ldr x9, [x21, #32]
    add x9, x9, #1
    str x9, [x21, #32]
    b update_extrema

update_extrema:
    // Update minimum and maximum using helper
    mov x0, x23 // update_min_max expects the current array element to be checked in x0.
    mov x1, x21 // update_min_max expects the current array value to be in address in x1.
    bl update_min_max

    // Move to next element
    add x22, x22, #1
    b loop

done:
    // Restore saved registers because if another program uses them then whatever
    // was in the registers needs to be saved
    ldr x23, [sp, #48]
    ldp x21, x22, [sp, #32]
    ldp x19, x20, [sp, #16]
    ldp x29, x30, [sp], #64
    ret

.size analyze_array, .-analyze_array
.section .note.GNU-stack,"",@progbits
