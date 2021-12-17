
.global _start
_start:
  movn x0, #:prel_g1:.+0xffffffff
  movn x0, #:prel_g1:.-0x100000000
