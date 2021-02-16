
.data
  msg: .ascii "Hello Worlds"
  fn: .ascii "Greeting2.txt"

.text
.global _start

createFile: # filename top of stack, replaces it with fd
  pop %rdx # pop return address
  mov $8, %rax # create file
  pop %rbx # filename from stack
  mov $0777, %rcx
  int $0x80
  push %rax
  push %rdx # restore return address
  ret

_start:
  mov $fn, %rbx
  push %rbx
  call createFile
  pop %rbx # get fd

  mov $4, %rax # output text to file
  mov $msg, %rcx
  mov $12, %rdx
  int $0x80
  mov $1, %rax
  mov $0, %rbx
  int $0x80
