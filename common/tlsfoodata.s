.section .tdata,"awT",%progbits
.global tlsfoodata
.type tlsfoodata,%object
.size tlsfoodata, 4
tlsfoodata:
  .word 0x42

.global tlsbardata
.type tlsbardata,%object
.size tlsbardata, 4
tlsbardata:
  .word 0x84
