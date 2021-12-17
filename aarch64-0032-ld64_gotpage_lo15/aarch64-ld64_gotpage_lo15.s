
.global _start
_start:
  ldr x24, [x23, #:gotpage_lo15:foo]
  ldr d22, [x21, :gotpage_lo15:foo]
// This works, but writes an extra GOT entry, which doesn't feel right.
// In comparison, GNU ld folds the GOT entries.
// The two entries are, however, identical, so it will work at runtime.
  ldr d22, [x23, :gotpage_lo15:foo+7]
// CHECK: ldr x24, [x23, :gotpage_lo15:sym]
// CHECK: ldr d22, [x21, :gotpage_lo15:sym]
// CHECK: ldr d22, [x23, :gotpage_lo15:sym+7]
// CHECK-OBJ-LP64: R_AARCH64_LD64_GOTPAGE_LO15 sym{{$}}
// CHECK-OBJ-LP64: R_AARCH64_LD64_GOTPAGE_LO15 sym{{$}}
// CHECK-OBJ-LP64: R_AARCH64_LD64_GOTPAGE_LO15 sym+0x7
