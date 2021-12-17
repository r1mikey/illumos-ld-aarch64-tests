
.global _start
_start:
   adrp x15, :got:foo
// CHECK: adrp x15, :got:sym
// CHECK-OBJ-LP64: 58 R_AARCH64_ADR_GOT_PAGE sym
