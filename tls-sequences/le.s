	.arch armv8-a
	.file	"le.c"
	.text
	.global	tls_var
	.section	.tbss,"awT",@nobits
	.align	2
	.type	tls_var, %object
	.size	tls_var, 4
tls_var:
	.zero	4
	.text
	.align	2
	.global	get_addr
	.type	get_addr, %function
get_addr:
	mrs	x0, tpidr_el0
	add	x0, x0, #:tprel_hi12:tls_var, lsl #12
	add	x0, x0, #:tprel_lo12_nc:tls_var
	ret
	.size	get_addr, .-get_addr
