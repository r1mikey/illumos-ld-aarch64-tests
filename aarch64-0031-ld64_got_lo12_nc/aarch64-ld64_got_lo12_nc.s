
.global _start
_start:
//    adrp    x8, :got:zero             // R_AARCH64_ADR_GOT_PAGE
//    ldr     x8, [x8, :got_lo12:zero]  // R_AARCH64_LD64_GOT_LO12_NC
//    ldr     w0, [x8]

//   ldr x24, [x23, #:got_lo12:foo]
   ldr d22, [x21, :got_lo12:foo]
#   ldr x24, [x23, :got_lo12:foo+7]
// CHECK: ldr x24, [x23, :got_lo12:foo]
// CHECK: ldr d22, [x21, :got_lo12:foo]
// CHECK: ldr x24, [x23, :got_lo12:foo+7]
// CHECK-OBJ-LP64: R_AARCH64_LD64_GOT_LO12_NC foo
// CHECK-OBJ-LP64: R_AARCH64_LD64_GOT_LO12_NC foo
// CHECK-OBJ-LP64: R_AARCH64_LD64_GOT_LO12_NC foo+0x7
