
.global _start
_start:
  movn x0, #:prel_g0:.+0xffff
  movn x0, #:prel_g0:.-0x10000
