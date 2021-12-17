
.global _start
_start:
  movn x0, #:prel_g3:.+0xffff000000000000
  movn x0, #:prel_g3:.-0xffff000000000000
