.p2align 4
.globl foo
foo:
  bl      .Lfoo                     // R_AARCH64_CALL26
.rodata
.Lfoo:
  .word 0
