	.file	"top.c"
	.option nopic
	.attribute arch, "rv32i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/ubuntu/final_project/lab-wlos_baseline/testbench/top" "top.c"
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
.LFB316:
	.file 1 "../../firmware/stub.c"
	.loc 1 19 1
	.cfi_startproc
.LVL0:
	.loc 1 20 2
	.loc 1 20 5 is_stmt 0
	li	a5,10
	beq	a0,a5,.L8
.L2:
	.loc 1 22 13 discriminator 1
	li	a4,-268410880
	.loc 1 22 60 discriminator 1
	li	a3,1
.L4:
	.loc 1 22 60 is_stmt 1 discriminator 1
	.loc 1 22 13 is_stmt 0 discriminator 1
	lw	a5,-2044(a4)
	.loc 1 22 60 discriminator 1
	beq	a5,a3,.L4
	.loc 1 23 2 is_stmt 1
	.loc 1 23 50 is_stmt 0
	sw	a0,-2048(a4)
	.loc 1 24 1
	ret
.L8:
.LBB17:
.LBB18:
	.loc 1 22 13
	li	a4,-268410880
	.loc 1 22 60
	li	a3,1
.L3:
	.loc 1 22 60 is_stmt 1
	.loc 1 22 13 is_stmt 0
	lw	a5,-2044(a4)
	.loc 1 22 60
	beq	a5,a3,.L3
	.loc 1 23 2 is_stmt 1
	.loc 1 23 50 is_stmt 0
	li	a5,13
	sw	a5,-2048(a4)
	.loc 1 24 1
	j	.L2
.LBE18:
.LBE17:
	.cfi_endproc
.LFE316:
	.size	putchar, .-putchar
	.align	2
	.globl	print
	.type	print, @function
print:
.LFB317:
	.loc 1 27 1 is_stmt 1
	.cfi_startproc
.LVL1:
	.loc 1 28 2
	.loc 1 28 9
	lbu	a2,0(a0)
	beq	a2,zero,.L9
.LBB23:
.LBB24:
	.loc 1 20 5 is_stmt 0
	li	a1,10
.LBB25:
.LBB26:
	.loc 1 22 13
	li	a4,-268410880
	.loc 1 22 60
	li	a3,1
	.loc 1 23 50
	li	a6,13
.L14:
.LBE26:
.LBE25:
.LBE24:
.LBE23:
	.loc 1 29 3 is_stmt 1
	.loc 1 29 14 is_stmt 0
	addi	a0,a0,1
.LVL2:
.LBB31:
.LBB29:
	.loc 1 20 2 is_stmt 1
	.loc 1 20 5 is_stmt 0
	beq	a2,a1,.L12
.L13:
	.loc 1 22 60 is_stmt 1
	.loc 1 22 13 is_stmt 0
	lw	a5,-2044(a4)
	.loc 1 22 60
	beq	a5,a3,.L13
	.loc 1 23 2 is_stmt 1
	.loc 1 23 50 is_stmt 0
	sw	a2,-2048(a4)
.LVL3:
.LBE29:
.LBE31:
	.loc 1 28 9 is_stmt 1
	lbu	a2,0(a0)
	bne	a2,zero,.L14
.L9:
	.loc 1 30 1 is_stmt 0
	ret
.LVL4:
.L12:
.LBB32:
.LBB30:
.LBB28:
.LBB27:
	.loc 1 22 60 is_stmt 1
	.loc 1 22 13 is_stmt 0
	lw	a5,-2044(a4)
	.loc 1 22 60
	beq	a5,a3,.L12
	.loc 1 23 2 is_stmt 1
	.loc 1 23 50 is_stmt 0
	sw	a6,-2048(a4)
	.loc 1 24 1
	j	.L13
.LBE27:
.LBE28:
.LBE30:
.LBE32:
	.cfi_endproc
.LFE317:
	.size	print, .-print
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
.LFB323:
	.file 2 "top.c"
	.loc 2 47 1 is_stmt 1
	.cfi_startproc
	.loc 2 49 5
	.loc 2 79 5
	.loc 2 47 1 is_stmt 0
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	.loc 2 79 39
	li	a3,8192
	li	a5,637534208
	addi	a4,a3,-2039
	.loc 2 47 1
	sw	ra,12(sp)
	sw	s0,8(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	.loc 2 79 39
	sw	a4,160(a5)
	.loc 2 80 5 is_stmt 1
	.loc 2 80 39 is_stmt 0
	sw	a4,156(a5)
	.loc 2 81 5 is_stmt 1
	.loc 2 81 39 is_stmt 0
	sw	a4,152(a5)
	.loc 2 82 5 is_stmt 1
	.loc 2 82 39 is_stmt 0
	sw	a4,148(a5)
	.loc 2 83 5 is_stmt 1
	.loc 2 83 39 is_stmt 0
	sw	a4,144(a5)
	.loc 2 84 5 is_stmt 1
	.loc 2 84 39 is_stmt 0
	sw	a4,140(a5)
	.loc 2 85 5 is_stmt 1
	.loc 2 85 39 is_stmt 0
	sw	a4,136(a5)
	.loc 2 86 5 is_stmt 1
	.loc 2 86 39 is_stmt 0
	sw	a4,132(a5)
	.loc 2 87 5 is_stmt 1
	.loc 2 87 39 is_stmt 0
	sw	a4,128(a5)
	.loc 2 88 5 is_stmt 1
	.loc 2 88 39 is_stmt 0
	sw	a4,124(a5)
	.loc 2 89 5 is_stmt 1
	.loc 2 89 39 is_stmt 0
	sw	a4,120(a5)
	.loc 2 90 5 is_stmt 1
	.loc 2 90 39 is_stmt 0
	sw	a4,116(a5)
	.loc 2 91 5 is_stmt 1
	.loc 2 91 39 is_stmt 0
	sw	a4,112(a5)
	.loc 2 92 5 is_stmt 1
	.loc 2 92 39 is_stmt 0
	sw	a4,108(a5)
	.loc 2 93 5 is_stmt 1
	.loc 2 93 39 is_stmt 0
	sw	a4,104(a5)
	.loc 2 94 5 is_stmt 1
	.loc 2 94 39 is_stmt 0
	sw	a4,100(a5)
	.loc 2 96 5 is_stmt 1
	.loc 2 96 39 is_stmt 0
	sw	a4,96(a5)
	.loc 2 97 5 is_stmt 1
	.loc 2 97 39 is_stmt 0
	sw	a4,92(a5)
	.loc 2 98 5 is_stmt 1
	.loc 2 98 39 is_stmt 0
	sw	a4,88(a5)
	.loc 2 99 5 is_stmt 1
	.loc 2 99 39 is_stmt 0
	sw	a4,84(a5)
	.loc 2 100 5 is_stmt 1
	.loc 2 100 39 is_stmt 0
	sw	a4,80(a5)
	.loc 2 101 5 is_stmt 1
	.loc 2 101 39 is_stmt 0
	sw	a4,76(a5)
	.loc 2 102 5 is_stmt 1
	.loc 2 102 39 is_stmt 0
	sw	a4,72(a5)
	.loc 2 103 5 is_stmt 1
	.loc 2 103 39 is_stmt 0
	sw	a4,68(a5)
	.loc 2 104 5 is_stmt 1
	.loc 2 104 39 is_stmt 0
	sw	a4,64(a5)
	.loc 2 105 5 is_stmt 1
	.loc 2 105 39 is_stmt 0
	sw	a4,52(a5)
	.loc 2 106 5 is_stmt 1
	.loc 2 106 39 is_stmt 0
	sw	a4,48(a5)
	.loc 2 107 5 is_stmt 1
	.loc 2 107 39 is_stmt 0
	sw	a4,44(a5)
	.loc 2 108 5 is_stmt 1
	.loc 2 108 39 is_stmt 0
	sw	a4,40(a5)
	.loc 2 109 5 is_stmt 1
	.loc 2 109 39 is_stmt 0
	sw	a4,36(a5)
	.loc 2 111 5 is_stmt 1
	.loc 2 111 39 is_stmt 0
	addi	a3,a3,-2040
	.loc 2 112 39
	li	a4,1026
	.loc 2 111 39
	sw	a3,60(a5)
	.loc 2 112 5 is_stmt 1
	.loc 2 112 39 is_stmt 0
	sw	a4,56(a5)
	.loc 2 116 2 is_stmt 1
	.loc 2 116 36 is_stmt 0
	li	a4,1
	sw	a4,0(a5)
	.loc 2 117 2 is_stmt 1
	.loc 2 117 10 is_stmt 0
	li	a3,637534208
.L22:
	.loc 2 117 43 is_stmt 1 discriminator 1
	.loc 2 117 10 is_stmt 0 discriminator 1
	lw	a5,0(a3)
	.loc 2 117 43 discriminator 1
	beq	a5,a4,.L22
	.loc 2 121 2 is_stmt 1
	.loc 2 121 114 is_stmt 0
	li	a5,-268423168
	sw	zero,12(a5)
	.loc 2 121 57
	sw	zero,28(a5)
	.loc 2 122 2 is_stmt 1
	.loc 2 122 112 is_stmt 0
	li	a2,-1
	sw	a2,8(a5)
	.loc 2 122 56
	sw	a2,24(a5)
	.loc 2 123 2 is_stmt 1
	.loc 2 123 112 is_stmt 0
	sw	zero,4(a5)
	.loc 2 123 56
	sw	zero,20(a5)
	.loc 2 124 2 is_stmt 1
	.loc 2 124 100 is_stmt 0
	sw	zero,0(a5)
	.loc 2 124 50
	sw	zero,16(a5)
	.loc 2 127 2 is_stmt 1
	.loc 2 127 36 is_stmt 0
	li	a2,-1421869056
	sw	a2,12(a3)
	.loc 2 130 2 is_stmt 1
	.loc 2 130 56 is_stmt 0
	sw	zero,56(a5)
	.loc 2 133 2 is_stmt 1
	.loc 2 133 112 is_stmt 0
	sw	zero,8(a5)
	.loc 2 133 56
	sw	zero,24(a5)
	.loc 2 159 2 is_stmt 1
.LBB33:
.LBB34:
	.file 3 "../../firmware/irq_vex.h"
	.loc 3 24 2
	.loc 3 25 2
 #APP
# 25 "../../firmware/irq_vex.h" 1
	csrr a5, 3008
# 0 "" 2
.LVL5:
	.loc 3 26 2
 #NO_APP
.LBE34:
.LBE33:
	.loc 2 160 2
	.loc 2 161 2
.LBB35:
.LBB36:
	.loc 3 31 2
	ori	a5,a5,4
.LVL6:
 #APP
# 31 "../../firmware/irq_vex.h" 1
	csrw 3008, a5
# 0 "" 2
.LVL7:
 #NO_APP
.LBE36:
.LBE35:
	.loc 2 163 2
.LBB37:
	.file 4 "../../firmware/csr.h"
	.loc 4 806 2
.LBB38:
.LBB39:
	.file 5 "../../firmware/hw/common.h"
	.loc 5 34 2
	.loc 5 34 32 is_stmt 0
	li	a5,-268406784
.LVL8:
	sw	a4,-2028(a5)
.LVL9:
.LBE39:
.LBE38:
.LBE37:
	.loc 2 167 2 is_stmt 1
	.loc 2 167 14 is_stmt 0
	call	fir
.LVL10:
	.loc 2 168 2 is_stmt 1
.LBB40:
	.loc 2 168 7
	.loc 2 168 20
	addi	a4,a0,256
	.loc 2 169 37 is_stmt 0
	li	s0,637534208
.LVL11:
.L23:
	.loc 2 169 3 is_stmt 1 discriminator 3
	.loc 2 169 51 is_stmt 0 discriminator 3
	lw	a5,0(a0)
	.loc 2 168 20 discriminator 3
	addi	a0,a0,4
	.loc 2 169 51 discriminator 3
	slli	a5,a5,16
	.loc 2 169 37 discriminator 3
	sw	a5,12(s0)
	.loc 2 168 27 is_stmt 1 discriminator 3
	.loc 2 168 20 discriminator 3
	bne	a4,a0,.L23
.LBE40:
	.loc 2 171 2
	.loc 2 171 36 is_stmt 0
	li	a5,-1419706368
	sw	a5,12(s0)
	.loc 2 173 2 is_stmt 1
	.loc 2 173 14 is_stmt 0
	call	qsort
.LVL12:
	.loc 2 174 2 is_stmt 1
	.loc 2 174 44 is_stmt 0
	lw	a4,0(a0)
	.loc 2 175 48
	lw	a5,4(a0)
	.loc 2 176 48
	lw	a2,8(a0)
	.loc 2 177 48
	lw	a3,12(a0)
	.loc 2 174 44
	slli	a4,a4,16
	.loc 2 174 36
	sw	a4,12(s0)
	.loc 2 175 2 is_stmt 1
	.loc 2 175 48 is_stmt 0
	slli	a5,a5,16
	.loc 2 178 48
	lw	a4,16(a0)
	.loc 2 176 48
	slli	a2,a2,16
	.loc 2 175 36
	sw	a5,12(s0)
	.loc 2 176 2 is_stmt 1
	.loc 2 179 48 is_stmt 0
	lw	a5,20(a0)
	.loc 2 177 48
	slli	a3,a3,16
	.loc 2 176 36
	sw	a2,12(s0)
	.loc 2 177 2 is_stmt 1
	.loc 2 180 48 is_stmt 0
	lw	a2,24(a0)
	.loc 2 178 48
	slli	a4,a4,16
	.loc 2 177 36
	sw	a3,12(s0)
	.loc 2 178 2 is_stmt 1
	.loc 2 181 48 is_stmt 0
	lw	a3,28(a0)
	.loc 2 179 48
	slli	a5,a5,16
	.loc 2 178 36
	sw	a4,12(s0)
	.loc 2 179 2 is_stmt 1
	.loc 2 182 48 is_stmt 0
	lw	a4,32(a0)
	.loc 2 180 48
	slli	a2,a2,16
	.loc 2 179 36
	sw	a5,12(s0)
	.loc 2 180 2 is_stmt 1
	.loc 2 183 48 is_stmt 0
	lw	a5,36(a0)
	.loc 2 181 48
	slli	a3,a3,16
	.loc 2 180 36
	sw	a2,12(s0)
	.loc 2 181 2 is_stmt 1
	.loc 2 181 36 is_stmt 0
	sw	a3,12(s0)
	.loc 2 182 2 is_stmt 1
	.loc 2 182 48 is_stmt 0
	slli	a4,a4,16
	.loc 2 182 36
	sw	a4,12(s0)
	.loc 2 183 2 is_stmt 1
	.loc 2 183 48 is_stmt 0
	slli	a5,a5,16
	.loc 2 183 36
	sw	a5,12(s0)
	.loc 2 184 2 is_stmt 1
	.loc 2 184 36 is_stmt 0
	li	a5,-1418657792
	sw	a5,12(s0)
	.loc 2 187 2 is_stmt 1
	.loc 2 187 14 is_stmt 0
	call	matmul
.LVL13:
	.loc 2 188 2 is_stmt 1
	.loc 2 188 44 is_stmt 0
	lw	a5,0(a0)
	.loc 2 189 48
	lw	a2,4(a0)
	.loc 2 190 48
	lw	a3,8(a0)
	.loc 2 191 48
	lw	a4,12(a0)
	.loc 2 188 44
	slli	a5,a5,16
	.loc 2 188 36
	sw	a5,12(s0)
	.loc 2 189 2 is_stmt 1
	.loc 2 189 48 is_stmt 0
	slli	a2,a2,16
	.loc 2 192 48
	lw	a5,36(a0)
	.loc 2 190 48
	slli	a3,a3,16
	.loc 2 189 36
	sw	a2,12(s0)
	.loc 2 190 2 is_stmt 1
	.loc 2 190 36 is_stmt 0
	sw	a3,12(s0)
	.loc 2 191 2 is_stmt 1
	.loc 2 191 48 is_stmt 0
	slli	a4,a4,16
	.loc 2 191 36
	sw	a4,12(s0)
	.loc 2 192 2 is_stmt 1
	.loc 2 192 48 is_stmt 0
	slli	a5,a5,16
	.loc 2 192 36
	sw	a5,12(s0)
	.loc 2 193 2 is_stmt 1
	.loc 2 193 36 is_stmt 0
	li	a5,-1420754944
	.loc 2 195 1
	lw	ra,12(sp)
	.cfi_restore 1
	.loc 2 193 36
	sw	a5,12(s0)
	.loc 2 195 1
	lw	s0,8(sp)
	.cfi_restore 8
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE323:
	.size	main, .-main
	.text
.Letext0:
	.file 6 "/opt/riscv/lib/gcc/riscv32-unknown-elf/12.1.0/include/stdint-gcc.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x2c3
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0xd
	.4byte	.LASF22
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.LLRL12
	.4byte	0
	.4byte	.Ldebug_line0
	.byte	0x1
	.byte	0x1
	.byte	0x6
	.4byte	.LASF2
	.byte	0x1
	.byte	0x2
	.byte	0x5
	.4byte	.LASF3
	.byte	0x1
	.byte	0x4
	.byte	0x5
	.4byte	.LASF4
	.byte	0x1
	.byte	0x8
	.byte	0x5
	.4byte	.LASF5
	.byte	0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF6
	.byte	0x1
	.byte	0x2
	.byte	0x7
	.4byte	.LASF7
	.byte	0xe
	.4byte	.LASF23
	.byte	0x6
	.byte	0x34
	.byte	0x1b
	.4byte	0x5c
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.byte	0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF9
	.byte	0xf
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.byte	0x8
	.4byte	.LASF11
	.byte	0x1a
	.4byte	0x88
	.4byte	0x88
	.byte	0x3
	.byte	0
	.byte	0x9
	.4byte	0x6a
	.byte	0x8
	.4byte	.LASF12
	.byte	0x21
	.4byte	0x88
	.4byte	0x9d
	.byte	0x3
	.byte	0
	.byte	0x10
	.string	"fir"
	.byte	0x2
	.byte	0x22
	.byte	0xd
	.4byte	0x88
	.4byte	0xaf
	.byte	0x3
	.byte	0
	.byte	0x11
	.4byte	.LASF24
	.byte	0x2
	.byte	0x2e
	.byte	0x6
	.4byte	.LFB323
	.4byte	.LFE323-.LFB323
	.byte	0x1
	.byte	0x9c
	.4byte	0x1af
	.byte	0x4
	.4byte	.LASF13
	.byte	0x31
	.byte	0x9
	.4byte	0x6a
	.4byte	.LLST4
	.byte	0x4
	.4byte	.LASF14
	.byte	0xa7
	.byte	0x7
	.4byte	0x88
	.4byte	.LLST5
	.byte	0x4
	.4byte	.LASF15
	.byte	0xad
	.byte	0x7
	.4byte	0x88
	.4byte	.LLST6
	.byte	0x12
	.4byte	.LASF16
	.byte	0x2
	.byte	0xbb
	.byte	0x7
	.4byte	0x88
	.byte	0x1
	.byte	0x5a
	.byte	0x13
	.4byte	.LBB40
	.4byte	.LBE40-.LBB40
	.4byte	0x11c
	.byte	0x14
	.string	"i"
	.byte	0x2
	.byte	0xa8
	.byte	0xb
	.4byte	0x6a
	.4byte	.LLST11
	.byte	0
	.byte	0x5
	.4byte	0x1c7
	.4byte	.LBB33
	.4byte	.LBE33-.LBB33
	.byte	0x9f
	.byte	0x9
	.4byte	0x135
	.byte	0x15
	.4byte	0x1d8
	.byte	0
	.byte	0x5
	.4byte	0x1af
	.4byte	.LBB35
	.4byte	.LBE35-.LBB35
	.byte	0xa1
	.byte	0x2
	.4byte	0x152
	.byte	0x2
	.4byte	0x1ba
	.4byte	.LLST7
	.byte	0
	.byte	0x5
	.4byte	0x25f
	.4byte	.LBB37
	.4byte	.LBE37-.LBB37
	.byte	0xa3
	.byte	0x2
	.4byte	0x193
	.byte	0x2
	.4byte	0x26d
	.4byte	.LLST8
	.byte	0x16
	.4byte	0x279
	.4byte	.LBB38
	.4byte	.LBE38-.LBB38
	.byte	0x4
	.2byte	0x326
	.byte	0x2
	.byte	0x2
	.4byte	0x28e
	.4byte	.LLST9
	.byte	0x2
	.4byte	0x284
	.4byte	.LLST8
	.byte	0
	.byte	0
	.byte	0x6
	.4byte	.LVL10
	.4byte	0x9d
	.byte	0x6
	.4byte	.LVL12
	.4byte	0x8d
	.byte	0x6
	.4byte	.LVL13
	.4byte	0x78
	.byte	0
	.byte	0xa
	.4byte	.LASF19
	.byte	0x3
	.byte	0x1d
	.4byte	0x1c7
	.byte	0x17
	.4byte	.LASF13
	.byte	0x3
	.byte	0x1d
	.byte	0x2d
	.4byte	0x71
	.byte	0
	.byte	0x18
	.4byte	.LASF25
	.byte	0x3
	.byte	0x16
	.byte	0x1c
	.4byte	0x71
	.byte	0x3
	.4byte	0x1e5
	.byte	0x19
	.4byte	.LASF13
	.byte	0x3
	.byte	0x18
	.byte	0xf
	.4byte	0x71
	.byte	0
	.byte	0x1a
	.4byte	.LASF26
	.byte	0x1
	.byte	0x1a
	.byte	0x6
	.4byte	.LFB317
	.4byte	.LFE317-.LFB317
	.byte	0x1
	.byte	0x9c
	.4byte	0x236
	.byte	0x1b
	.string	"p"
	.byte	0x1
	.byte	0x1a
	.byte	0x18
	.4byte	0x236
	.4byte	.LLST0
	.byte	0xb
	.4byte	0x247
	.4byte	.LBB23
	.4byte	.LLRL1
	.byte	0x1d
	.byte	0x2
	.4byte	0x254
	.4byte	.LLST2
	.byte	0xb
	.4byte	0x247
	.4byte	.LBB25
	.4byte	.LLRL3
	.byte	0x15
	.byte	0xc
	.4byte	0x254
	.byte	0
	.byte	0
	.byte	0
	.byte	0x9
	.4byte	0x242
	.byte	0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF17
	.byte	0x1c
	.4byte	0x23b
	.byte	0x1d
	.4byte	.LASF18
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x1
	.4byte	0x25f
	.byte	0x7
	.string	"c"
	.byte	0x1
	.byte	0x12
	.byte	0x13
	.4byte	0x23b
	.byte	0
	.byte	0x1e
	.4byte	.LASF20
	.byte	0x4
	.2byte	0x325
	.byte	0x14
	.byte	0x3
	.4byte	0x279
	.byte	0x1f
	.string	"v"
	.byte	0x4
	.2byte	0x325
	.byte	0x38
	.4byte	0x50
	.byte	0
	.byte	0xa
	.4byte	.LASF21
	.byte	0x5
	.byte	0x20
	.4byte	0x299
	.byte	0x7
	.string	"v"
	.byte	0x5
	.byte	0x20
	.byte	0x33
	.4byte	0x5c
	.byte	0x7
	.string	"a"
	.byte	0x5
	.byte	0x20
	.byte	0x44
	.4byte	0x5c
	.byte	0
	.byte	0x20
	.4byte	0x247
	.4byte	.LFB316
	.4byte	.LFE316-.LFB316
	.byte	0x1
	.byte	0x9c
	.byte	0x21
	.4byte	0x254
	.byte	0x1
	.byte	0x5a
	.byte	0x22
	.4byte	0x247
	.4byte	.LBB17
	.4byte	.LBE17-.LBB17
	.byte	0x1
	.byte	0x15
	.byte	0x3
	.byte	0xc
	.4byte	0x254
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x2
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x58
	.byte	0x21
	.byte	0x2
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0x48
	.byte	0
	.byte	0x7d
	.byte	0x1
	.byte	0x7f
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x2
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0xd
	.byte	0x49
	.byte	0x13
	.byte	0x3c
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0xf
	.byte	0
	.byte	0xb
	.byte	0x21
	.byte	0x4
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x14
	.byte	0x27
	.byte	0x19
	.byte	0x20
	.byte	0x21
	.byte	0x3
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xb
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x52
	.byte	0x1
	.byte	0x55
	.byte	0x17
	.byte	0x58
	.byte	0x21
	.byte	0x1
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0x21
	.byte	0x3
	.byte	0
	.byte	0
	.byte	0xc
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xd
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0x1f
	.byte	0x1b
	.byte	0x1f
	.byte	0x55
	.byte	0x17
	.byte	0x11
	.byte	0x1
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0xe
	.byte	0x16
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xf
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0x10
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x3c
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x11
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x12
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x13
	.byte	0xb
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x14
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x15
	.byte	0x34
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x16
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x58
	.byte	0xb
	.byte	0x59
	.byte	0x5
	.byte	0x57
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x17
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x18
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x49
	.byte	0x13
	.byte	0x20
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x19
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x1a
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x1b
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x1c
	.byte	0x26
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x1d
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x20
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x1e
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0x5
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x20
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x1f
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0x5
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x20
	.byte	0x2e
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0
	.byte	0
	.byte	0x21
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x22
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x58
	.byte	0xb
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.4byte	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.Ldebug_loc0:
.LLST4:
	.byte	0x7
	.4byte	.LVL5
	.4byte	.LVL6
	.byte	0x5
	.byte	0x7f
	.byte	0
	.byte	0x34
	.byte	0x21
	.byte	0x9f
	.byte	0x7
	.4byte	.LVL6
	.4byte	.LVL8
	.byte	0x1
	.byte	0x5f
	.byte	0
.LLST5:
	.byte	0x7
	.4byte	.LVL10
	.4byte	.LVL11
	.byte	0x1
	.byte	0x5a
	.byte	0x7
	.4byte	.LVL11
	.4byte	.LVL12-1
	.byte	0x4
	.byte	0x7e
	.byte	0x80,0x7e
	.byte	0x9f
	.byte	0
.LLST6:
	.byte	0x7
	.4byte	.LVL12
	.4byte	.LVL13-1
	.byte	0x1
	.byte	0x5a
	.byte	0
.LLST11:
	.byte	0x7
	.4byte	.LVL10
	.4byte	.LVL11
	.byte	0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LLST7:
	.byte	0x7
	.4byte	.LVL5
	.4byte	.LVL6
	.byte	0x5
	.byte	0x7f
	.byte	0
	.byte	0x34
	.byte	0x21
	.byte	0x9f
	.byte	0x7
	.4byte	.LVL6
	.4byte	.LVL7
	.byte	0x1
	.byte	0x5f
	.byte	0
.LLST8:
	.byte	0x7
	.4byte	.LVL7
	.4byte	.LVL9
	.byte	0x2
	.byte	0x31
	.byte	0x9f
	.byte	0
.LLST9:
	.byte	0x7
	.4byte	.LVL7
	.4byte	.LVL9
	.byte	0x6
	.byte	0x9e
	.byte	0x4
	.4byte	0xf0006814
	.byte	0
.LLST0:
	.byte	0x7
	.4byte	.LVL1
	.4byte	.LVL2
	.byte	0x1
	.byte	0x5a
	.byte	0x7
	.4byte	.LVL2
	.4byte	.LFE317
	.byte	0x1
	.byte	0x5a
	.byte	0
.LLST2:
	.byte	0x7
	.4byte	.LVL2
	.4byte	.LVL3
	.byte	0x1
	.byte	0x5c
	.byte	0x7
	.4byte	.LVL4
	.4byte	.LFE317
	.byte	0x1
	.byte	0x5c
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.LFB323
	.4byte	.LFE323-.LFB323
	.4byte	0
	.4byte	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.4byte	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.LLRL1:
	.byte	0x6
	.4byte	.LBB23
	.4byte	.LBE23
	.byte	0x6
	.4byte	.LBB31
	.4byte	.LBE31
	.byte	0x6
	.4byte	.LBB32
	.4byte	.LBE32
	.byte	0
.LLRL3:
	.byte	0x6
	.4byte	.LBB25
	.4byte	.LBE25
	.byte	0x6
	.4byte	.LBB28
	.4byte	.LBE28
	.byte	0
.LLRL12:
	.byte	0x6
	.4byte	.Ltext0
	.4byte	.Letext0
	.byte	0x6
	.4byte	.LFB323
	.4byte	.LFE323
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF21:
	.string	"csr_write_simple"
.LASF16:
	.string	"tmp1"
.LASF15:
	.string	"tmp2"
.LASF14:
	.string	"tmp3"
.LASF11:
	.string	"matmul"
.LASF12:
	.string	"qsort"
.LASF6:
	.string	"unsigned char"
.LASF8:
	.string	"long unsigned int"
.LASF7:
	.string	"short unsigned int"
.LASF18:
	.string	"putchar"
.LASF24:
	.string	"main"
.LASF25:
	.string	"irq_getmask"
.LASF19:
	.string	"irq_setmask"
.LASF10:
	.string	"unsigned int"
.LASF22:
	.string	"GNU C17 12.1.0 -mabi=ilp32 -mtune=rocket -misa-spec=2.2 -march=rv32i -g -O3 -ffreestanding"
.LASF20:
	.string	"user_irq_0_ev_enable_write"
.LASF9:
	.string	"long long unsigned int"
.LASF5:
	.string	"long long int"
.LASF13:
	.string	"mask"
.LASF26:
	.string	"print"
.LASF3:
	.string	"short int"
.LASF23:
	.string	"uint32_t"
.LASF4:
	.string	"long int"
.LASF17:
	.string	"char"
.LASF2:
	.string	"signed char"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/ubuntu/final_project/lab-wlos_baseline/testbench/top"
.LASF0:
	.string	"top.c"
	.ident	"GCC: (g1ea978e3066) 12.1.0"
