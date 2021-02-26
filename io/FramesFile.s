
.data
  msg: .ascii "Hello Framey Worlds"
  fn: .ascii "Greeting3.txt"
  buf: .quad 0

.text
.global _start

createFile: # filename top of stack, replaces it with fd
  pushq %rbp
  movq %rsp, %rbp
  movq $8, %rax # create file
  movq 16(%rbp), %rbx # filename from stack
  movq $0777, %rcx
  int $0x80
  movq %rax, 16(%rbp)
  mov %rbp, %rsp # leave
  popq %rbp
  ret

writeFile:
  pushq %rbp
  movq %rsp, %rbp
  movq 24(%rbp), %rcx # get msg, to rcx
  movq 16(%rbp), %rbx # get fd, to rbx
  movq $4, %rax # output text to file
  movq $19, %rdx
  int $0x80
  mov %rbp, %rsp # leave
  popq %rbp
  ret

_start:
  pushq %rbp
  movq %rsp, %rbp
  mov $fn, %rbx
  mov %rbx, (%rbp)
  call createFile
  movq $msg, 8(%rbp)
  call writeFile
  movq $1, %rax
  movq $0, %rbx
  int $0x80
  mov %rbp, %rsp # leave
  popq %rbp
