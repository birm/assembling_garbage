
.data
  msg: .ascii "Hello World"
  fn: .ascii "Greeting.txt"
  fd: .byte 0

.text
.global _start


_start:
  mov $8, %eax # create file
  mov $fn, %ebx
  mov $0777, %ecx
  int $0x80

  mov %eax, fd

  mov $4, %eax # output text to file
  mov fd, %ebx
  mov $msg, %ecx
  mov $11, %edx
  int $0x80
  mov $1, %eax
  mov $0, %ebx
  int $0x80
