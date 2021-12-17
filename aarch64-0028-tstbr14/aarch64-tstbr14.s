.p2align 4
.global foo
foo:
.Lbranch:
  tbz     x1, 7, .Lfoo           // R_AARCH64_TSTBR14

.rodata
.Lfoo:
.long 0x42
