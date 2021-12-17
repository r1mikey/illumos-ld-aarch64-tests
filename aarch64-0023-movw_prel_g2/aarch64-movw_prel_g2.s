
.global _start
_start:
  movn x0, #:prel_g2:.+0xffffffffffff
  movn x0, #:prel_g2:.-0x1000000000000
