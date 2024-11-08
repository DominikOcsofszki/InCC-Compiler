; ASM_FILE:
; seq_multi
.text
	.global main
	.align	2

main:
;Add for sanity_checks
	mov x0, #1993
	mov x1, #1111
	mov x2, #2222
	mov x3, #3333
	mov x4, #4444
	mov x5, #5555
	mov x6, #6666
	mov x7, #7777
	mov x20, sp; x20 as BottomStackPointer
	sub sp, sp, #32; x20 as BottomStackPointer
	stp FP, LR, [sp, -0x10]!;epilogue

;==============================
;========STACK_MACHINE=========
;==============================
	mov x0, #2
	str	x0, [SP, #-16]!;push!
	mov x0, #16
	str	x0, [SP, #-16]!;push!
;==============>>>>>>>>>>>STORE-GLOBAL===========
	ldr x1, [sp], #16
	ldr x0, [sp], #16
	mov x7, x20;			  SPBase(x20) into x7
	sub x7, x7, x1;			Add calced address to SPBase
	str x0, [x7];			  load lvalue in rvalue
	str	x0, [SP, #-16]!;push!
;==============<<<<<<<<<<<STORE-GLOBAL===========
	ldr x0, [sp], #16; POP!!!!!!!
	mov x0, #16
	str	x0, [SP, #-16]!;push!
;==============>>>>>>>>>>>LOAD-GLOBAL============
	ldr x0, [sp], #16; POP!!!!!!!
	mov x7, x20;			  SPBase(x20) into x7
	sub x7, x7, x0;			Add calced address to SPBase
	ldr x0, [x7];			  load lvalue in rvalue
	str	x0, [SP, #-16]!;push!
;==============<<<<<<<<<<<LOAD-GLOBAL============
	mov x0, #500
	str	x0, [SP, #-16]!;push!
	ldr x2, [sp], #16
	ldr x1, [sp], #16
	mul x0, x1, x2
	str	x0, [SP, #-16]!;push!
	mov x0, #32
	str	x0, [SP, #-16]!;push!
;==============>>>>>>>>>>>STORE-GLOBAL===========
	ldr x1, [sp], #16
	ldr x0, [sp], #16
	mov x7, x20;			  SPBase(x20) into x7
	sub x7, x7, x1;			Add calced address to SPBase
	str x0, [x7];			  load lvalue in rvalue
	str	x0, [SP, #-16]!;push!
;==============<<<<<<<<<<<STORE-GLOBAL===========
	ldr x0, [sp], #16; POP!!!!!!!
	mov x0, #16
	str	x0, [SP, #-16]!;push!
;==============>>>>>>>>>>>LOAD-GLOBAL============
	ldr x0, [sp], #16; POP!!!!!!!
	mov x7, x20;			  SPBase(x20) into x7
	sub x7, x7, x0;			Add calced address to SPBase
	ldr x0, [x7];			  load lvalue in rvalue
	str	x0, [SP, #-16]!;push!
;==============<<<<<<<<<<<LOAD-GLOBAL============
	ldr x0, [sp], #16; POP!!!!!!!
	mov x0, #32
	str	x0, [SP, #-16]!;push!
;==============>>>>>>>>>>>LOAD-GLOBAL============
	ldr x0, [sp], #16; POP!!!!!!!
	mov x7, x20;			  SPBase(x20) into x7
	sub x7, x7, x0;			Add calced address to SPBase
	ldr x0, [x7];			  load lvalue in rvalue
	str	x0, [SP, #-16]!;push!
;==============<<<<<<<<<<<LOAD-GLOBAL============
;==============================
;========STACK_MACHINE=========
;==============================

	adrp x0, FinalResult@PAGE
	add x0, x0, FinalResult@PAGEOFF
	bl _printf
	add sp, sp, 0x10; move pointer back to top stack item + print removes it
	adrp x0, IR@PAGE
	add x0, x0, IR@PAGEOFF
	bl _printf

	ldp FP, LR, [sp], 0x10;prologue:

	;===Local Vars, remove!
	add sp, sp, #32; x20 as BottomStackPointer
	mov x0, #0
	ret
.data
FinalResult: .asciz "FinalResult: %d \n"
HelperResult: .asciz "HelperResult: %d \n"
.data
IR: .asciz "
=========IR-CODE===========
loadc 2
loadc 16
store
pop
loada 16
loadc 500
mul
loadc 32
store
pop
loada 16
pop
loada 32
=========IR-CODE===========
"