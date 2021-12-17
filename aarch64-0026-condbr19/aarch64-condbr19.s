.p2align 4
.globl foo
foo:
  beq     .Lfoo                     // R_AARCH64_CONDBR19
.data
.Lfoo:
  .word 0
