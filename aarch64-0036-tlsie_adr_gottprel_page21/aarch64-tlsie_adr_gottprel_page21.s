#        .global tlsievar
#        .section        .tbss,"awT",%nobits
#        .align  2
#        .type   tlsievar, %object
#        .size   tlsievar, 4
#tlsievar:
#        .zero   4
#
.text
.global _start
_start:
        // R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21 tlsfoodata
        adrp x0, :gottprel:tlsfoodata
        // R_AARCH64_TLSIE_GOTTPREL_LO12_NC    tlsfoodata
        ldr  x0, [x0, :gottprel_lo12:tlsfoodata]

#        adrp x11, :gottprel:var
#        ldr x10, [x0, #:gottprel_lo12:var]
#        ldr x9, :gottprel:var
