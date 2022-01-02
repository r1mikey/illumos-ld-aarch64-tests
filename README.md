# illumos-ld-aarch64-tests

Notes
=====

There's no support for TLSDESC in the linker, so we'll stick to traditional TLS
for now.  TLSDESC doesn't look too hard, but it'll need support plumbed in to ld
in a generic way, and will need loader support.

I still need to make some progress on _P32 relocations.  These are required to
support the beta ILP32 mode of aarch64, which we'll use as our 32 bit
instruction set.  The kernel, much like Intel, will be 64 bit only.

Useful commands
===============

```
/opt/ooce/llvm-13/bin/llvm-objdump -r -d --disassemble-zeroes --section=.data t1.o
/opt/ooce/llvm-13/bin/llvm-objdump -r -d --disassemble-zeroes --section=.text t1.o
/opt/ooce/llvm-13/bin/llvm-objdump -R -D --disassemble-zeroes --section=.plt t1.exe
/opt/ooce/llvm-13/bin/llvm-objdump -R -d --disassemble-zeroes --section=.got t1.exe
/opt/ooce/llvm-13/bin/llvm-objdump -R -d --disassemble-zeroes --section=.data t1.exe
/opt/ooce/llvm-13/bin/llvm-objdump -R -d --disassemble-zeroes --section=.text t1.exe
/opt/ooce/llvm-13/bin/llvm-objdump -R t1.exe
```

From LLD relocation types
=========================

NOTE: TLS relocations are unimplemented for now.

* R_NONE
  * [x] R_AARCH64_NONE

* R_ABS
  * [x] R_AARCH64_ABS16
  * [x] R_AARCH64_ABS32
  * [x] R_AARCH64_ABS64
  * [x] R_AARCH64_ADD_ABS_LO12_NC
  * [x] R_AARCH64_LDST128_ABS_LO12_NC
  * [x] R_AARCH64_LDST16_ABS_LO12_NC
  * [x] R_AARCH64_LDST32_ABS_LO12_NC
  * [x] R_AARCH64_LDST64_ABS_LO12_NC
  * [x] R_AARCH64_LDST8_ABS_LO12_NC
  * [x] R_AARCH64_MOVW_SABS_G0
  * [x] R_AARCH64_MOVW_SABS_G1
  * [x] R_AARCH64_MOVW_SABS_G2
  * [x] R_AARCH64_MOVW_UABS_G0
  * [x] R_AARCH64_MOVW_UABS_G0_NC
  * [x] R_AARCH64_MOVW_UABS_G1
  * [x] R_AARCH64_MOVW_UABS_G1_NC
  * [x] R_AARCH64_MOVW_UABS_G2
  * [x] R_AARCH64_MOVW_UABS_G2_NC
  * [x] R_AARCH64_MOVW_UABS_G3

* R_PC
  * [x] R_AARCH64_PREL16
  * [x] R_AARCH64_PREL32
  * [x] R_AARCH64_PREL64
  * [x] R_AARCH64_ADR_PREL_LO21
  * [x] R_AARCH64_LD_PREL_LO19
  * [x] R_AARCH64_MOVW_PREL_G0
  * [x] R_AARCH64_MOVW_PREL_G0_NC
  * [x] R_AARCH64_MOVW_PREL_G1
  * [x] R_AARCH64_MOVW_PREL_G1_NC
  * [x] R_AARCH64_MOVW_PREL_G2
  * [x] R_AARCH64_MOVW_PREL_G2_NC
  * [x] R_AARCH64_MOVW_PREL_G3

* R_PLT_PC
  * [x] R_AARCH64_CALL26
  * [x] R_AARCH64_CONDBR19
  * [x] R_AARCH64_JUMP26
  * [x] R_AARCH64_TSTBR14
  * [x] R_AARCH64_PLT32

* R_AARCH64_PAGE_PC
  * [x] R_AARCH64_ADR_PREL_PG_HI21
  * [x] R_AARCH64_ADR_PREL_PG_HI21_NC

* R_GOT
  * [x] R_AARCH64_LD64_GOT_LO12_NC
  * [ ] TLS: R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC

* R_AARCH64_GOT_PAGE
  * [x] R_AARCH64_LD64_GOTPAGE_LO15

* R_AARCH64_GOT_PAGE_PC
  * [x] R_AARCH64_ADR_GOT_PAGE
  * [ ] TLS: R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21

* R_AARCH64_TLSDESC_PAGE
  * [ ] TLS: R_AARCH64_TLSDESC_ADR_PAGE21

* R_TLSDESC
  * [ ] TLS: R_AARCH64_TLSDESC_LD64_LO12
  * [ ] TLS: R_AARCH64_TLSDESC_ADD_LO12

* R_TLSDESC_CALL
  * [ ] TLS: R_AARCH64_TLSDESC_CALL

* R_TPREL
  * [ ] TLS: R_AARCH64_TLSLE_ADD_TPREL_HI12
  * [ ] TLS: R_AARCH64_TLSLE_ADD_TPREL_LO12_NC
  * [ ] TLS: R_AARCH64_TLSLE_LDST8_TPREL_LO12_NC
  * [ ] TLS: R_AARCH64_TLSLE_LDST16_TPREL_LO12_NC
  * [ ] TLS: R_AARCH64_TLSLE_LDST32_TPREL_LO12_NC
  * [ ] TLS: R_AARCH64_TLSLE_LDST64_TPREL_LO12_NC
  * [ ] TLS: R_AARCH64_TLSLE_LDST128_TPREL_LO12_NC
  * [ ] TLS: R_AARCH64_TLSLE_MOVW_TPREL_G0
  * [ ] TLS: R_AARCH64_TLSLE_MOVW_TPREL_G0_NC
  * [ ] TLS: R_AARCH64_TLSLE_MOVW_TPREL_G1
  * [ ] TLS: R_AARCH64_TLSLE_MOVW_TPREL_G1_NC
  * [ ] TLS: R_AARCH64_TLSLE_MOVW_TPREL_G2

Unimplemented in LLD
====================

* [ ] R_AARCH64_GOTREL32
* [ ] R_AARCH64_GOTREL64
* [ ] R_AARCH64_GOT_LD_PREL19
* [ ] R_AARCH64_LD64_GOTOFF_LO15
* [ ] R_AARCH64_MOVW_GOTOFF_G0
* [ ] R_AARCH64_MOVW_GOTOFF_G0_NC
* [ ] R_AARCH64_MOVW_GOTOFF_G1
* [ ] R_AARCH64_MOVW_GOTOFF_G1_NC
* [ ] R_AARCH64_MOVW_GOTOFF_G2
* [ ] R_AARCH64_MOVW_GOTOFF_G2_NC
* [ ] R_AARCH64_MOVW_GOTOFF_G3
* [ ] TLS: R_AARCH64_TLSDESC_ADR_PREL21
* [ ] TLS: R_AARCH64_TLSDESC_LDR
* [ ] TLS: R_AARCH64_TLSDESC_LD_PREL19
* [ ] TLS: R_AARCH64_TLSDESC_OFF_G0_NC
* [ ] TLS: R_AARCH64_TLSDESC_OFF_G1
* [ ] TLS: R_AARCH64_TLSGD_ADD_LO12_NC
* [ ] TLS: R_AARCH64_TLSGD_ADR_PAGE21
* [ ] TLS: R_AARCH64_TLSGD_ADR_PREL21
* [ ] TLS: R_AARCH64_TLSGD_MOVW_G0_NC
* [ ] TLS: R_AARCH64_TLSGD_MOVW_G1
* [ ] TLS: R_AARCH64_TLSIE_LD_GOTTPREL_PREL19
* [ ] TLS: R_AARCH64_TLSIE_MOVW_GOTTPREL_G0_NC
* [ ] TLS: R_AARCH64_TLSIE_MOVW_GOTTPREL_G1
* [ ] TLS: R_AARCH64_TLSLD_ADD_DTPREL_HI12
* [ ] TLS: R_AARCH64_TLSLD_ADD_DTPREL_LO12
* [ ] TLS: R_AARCH64_TLSLD_ADD_DTPREL_LO12_NC
* [ ] TLS: R_AARCH64_TLSLD_ADD_LO12_NC
* [ ] TLS: R_AARCH64_TLSLD_ADR_PAGE21
* [ ] TLS: R_AARCH64_TLSLD_ADR_PREL21
* [ ] TLS: R_AARCH64_TLSLD_LDST128_DTPREL_LO12
* [ ] TLS: R_AARCH64_TLSLD_LDST128_DTPREL_LO12_NC
* [ ] TLS: R_AARCH64_TLSLD_LDST16_DTPREL_LO12
* [ ] TLS: R_AARCH64_TLSLD_LDST16_DTPREL_LO12_NC
* [ ] TLS: R_AARCH64_TLSLD_LDST32_DTPREL_LO12
* [ ] TLS: R_AARCH64_TLSLD_LDST32_DTPREL_LO12_NC
* [ ] TLS: R_AARCH64_TLSLD_LDST64_DTPREL_LO12
* [ ] TLS: R_AARCH64_TLSLD_LDST64_DTPREL_LO12_NC
* [ ] TLS: R_AARCH64_TLSLD_LDST8_DTPREL_LO12
* [ ] TLS: R_AARCH64_TLSLD_LDST8_DTPREL_LO12_NC
* [ ] TLS: R_AARCH64_TLSLD_LD_PREL19
* [ ] TLS: R_AARCH64_TLSLD_MOVW_DTPREL_G0
* [ ] TLS: R_AARCH64_TLSLD_MOVW_DTPREL_G0_NC
* [ ] TLS: R_AARCH64_TLSLD_MOVW_DTPREL_G1
* [ ] TLS: R_AARCH64_TLSLD_MOVW_DTPREL_G1_NC
* [ ] TLS: R_AARCH64_TLSLD_MOVW_DTPREL_G2
* [ ] TLS: R_AARCH64_TLSLD_MOVW_G0_NC
* [ ] TLS: R_AARCH64_TLSLD_MOVW_G1
* [ ] TLS: R_AARCH64_TLSLE_ADD_TPREL_LO12 -- LLVM only does the _NC
* [ ] TLS: R_AARCH64_TLSLE_LDST128_TPREL_LO12 -- LLVM only does the _NC
* [ ] TLS: R_AARCH64_TLSLE_LDST16_TPREL_LO12 -- LLVM only does the _NC
* [ ] TLS: R_AARCH64_TLSLE_LDST32_TPREL_LO12 -- LLVM only does the _NC
* [ ] TLS: R_AARCH64_TLSLE_LDST64_TPREL_LO12 -- LLVM only does the _NC
* [ ] TLS: R_AARCH64_TLSLE_LDST8_TPREL_LO12 -- LLVM only does the _NC

Dynamic Relocations
===================

* [ ] R_AARCH64_COPY
* [x] R_AARCH64_GLOB_DAT
* [x] R_AARCH64_JUMP_SLOT
* [x] R_AARCH64_RELATIVE
* [ ] TLS: R_AARCH64_TLS_DTPREL (R_AARCH64_TLS_IMPDEF2)
* [ ] TLS: R_AARCH64_TLS_DTPMOD (R_AARCH64_TLS_IMPDEF1)
* [ ] TLS: R_AARCH64_TLS_TPREL
* [ ] TLS: R_AARCH64_TLSDESC
* [ ] R_AARCH64_IRELATIVE

TLS Sequences
=============

The first two are TLSDESC-based, which we need to plumb in support for.

General Dynamic:
  adrp  x0, :tlsdesc:var                        R_AARCH64_TLSDESC_ADR_PAGE21 var
  ldr   x1, [x0, #:tlsdesc_lo12:var]            R_AARCH64_TLSDESC_LD64_LO12 var
  add   x0, x0, #:tlsdesc_lo12:var              R_AARCH64_TLSDESC_ADD_LO12  var
  .tlsdesccall var
  blr   x1                                      R_AARCH64_TLSDESC_CALL      var
...
  mrs   tp, tpidr_el0
  add   x0, tp, x0
or
  mrs   tp, tpidr_el0
  ldr   x0, [tp, x0]

Local Dynamic:
  See General Dynamic.
  "To avoid the definition of new relocations, the linker simply defines for
   all modules that have a TLS section a hidden per-module symbol called
   _TLS_MODULE_BASE_ which denotes the beginning of the TLS section for that
   module."

Initial Exec:
    0x00 mrs  tp, tpidr_el0 
    ...
    0x04 adrp t0, :gottprel:x1                  R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21   x1
    0x08 ldr  t0, [t0, #:gottprel_lo12:x1]      R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC x1
    ...
    0x0c add  t0, tp

Local Exec:
    0x00 mrs  tp, tpidr_el0
    ...
    0x20 add  t0, tp, #:tprel_hi12:x1, lsl #12  R_AARCH64_TLSLE_ADD_TPREL_HI12       x2
    0x24 add  t0, #:tprel_lo12_nc:x1            R_AARCH64_TLSLE_ADD_TPREL_LO12_NC    x2

   (instead of the last add, the following can be used if the value of the variable,
    instead of its adrress, is needed:
    0x24 ldr  t0, [t0, #:tprel_lo12_nc:x1]      R_AARCH64_TLSLE_LDST64_TPREL_LO12_NC x2
   )

