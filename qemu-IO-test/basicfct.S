.data

/* from: https://peterdn.com/post/2020/08/22/hello-world-in-arm64-assembly/ */
msg:
    .ascii        "Hello, ARM64!\n"
len = . - msg

.text
.type    myadd,%function

.globl printh
printh:
    /* syscall write(int fd, const void *buf, size_t count) */
    mov     x0, #1      /* fd := STDOUT_FILENO */
    ldr     x1, =msg    /* buf := msg */
    ldr     x2, =len    /* count := len */
    mov     w8, #64     /* write is syscall #64 */
    svc     #0          /* invoke syscall */

    /* syscall exit(int status) */
    mov     x0, #0      /* status := 0 */
    mov     w8, #93     /* exit is syscall #1 */
    svc     #0          /* invoke syscall */