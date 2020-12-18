// AArch64 mode
 
// To keep this in the first portion of the binary.
.section ".text.boot"
 
// Make _start global.
.globl _start
 
.org 0x80000
// Entry point for the kernel. Registers:
// x0 -> 32 bit pointer to DTB in memory (primary core only) / 0 (secondary cores)
// x1 -> 0
// x2 -> 0
// x3 -> 0
// x4 -> 32 bit kernel entry point, _start location
_start:
    // read cpu id, stop slave cores
    mrs     x1, mpidr_el1
    and     x1, x1, #3
    cbz     x1, 2f
    // cpu id > 0, stop
1:  wfe
    b       1b
2:  // cpu id == 0

    // set stack before our code
    ldr     x5, =_start

    /*
    (0. init; necessary?)
    1. set ElX register
    2. set process state in saved program status register X
    3. put El(X-1) adress under ElX
    4. fake exception return call  
    exlvl check beforehand needed? 64bit should boot in E3
    */
    
    // Initialize SCTLR_EL2 and HCR_EL2 to save values before entering EL2.
    MSR SCTLR_EL2, XZR
    MSR HCR_EL2, XZR

    // Determine the EL2 Execution state.
    MRS X0, SCR_EL3
    ORR X0, X0, #(1<<10) // RW EL2 Execution state is AArch64.
    ORR X0, X0, #(1<<0) // NS since EL1 is Non-secure world.
    // or just mov x0, #0x401

    /*
    -> A: SError interrupt mask (PSTATE.A)
    -> F: FIQ interrupt mask
    -> T: T32 instruction set state
    -> M[3:0]: 0b1001 = El2h (M[3:2] = El level, M[1] = unused, M[0] = use SPx stack pointer (h/1; x = Ex lvl) or SP0 stack pointer(t/0))
    DAIF = allow access to the interrupt mask bits
    */
    MSR SCR_EL3, x0
    MOV X0, #0b01001 // DAIF=0000
    MSR SPSR_EL3, X0 // M[4:0]=01001 EL2h must match SCR_EL3.RW
    // Determine EL2 entry.
    ADR X0, goto_el1 // el2_entry points to the first instruction of
    MSR ELR_EL3, X0 // EL2 code.
    ERET

goto_el1: 
    MSR SCTLR_EL1, XZR
    // Determine the EL1 Execution state.
    MRS X0, HCR_EL2
    ORR X0, X0, #(1<<31) // RW=1 EL1 Execution state is AArch64.
    MSR HCR_EL2, X0
    MOV X0, #0b00101 // DAIF=0000
    MSR SPSR_EL2, X0 // M[4:0]=00101 EL1h must match HCR_EL2.RW.
    ADR X0, 5f // el1_entry points to the first instruction of
    MSR ELR_EL2, X0 // EL1 code.
    ERET

5:  mov     sp, x5

    // clear bss
    ldr     x5, =__bss_start
    ldr     w6, =__bss_size
3:  cbz     w6, 4f
    str     xzr, [x5], #8
    sub     w6, w6, #1
    cbnz    w6, 3b
 
    // jump to C code, should not return
4:  bl      kernel_main
    // for failsafe, halt this core too
    b    1b