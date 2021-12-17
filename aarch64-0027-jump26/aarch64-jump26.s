.p2align 4
.globl foo
foo:
  b       .Lfoo                     // R_AARCH64_JUMP26
.rodata
.Lfoo:
  .word 0
