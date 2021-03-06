# Test File for 40 Instruction, include:
# 1. Subset 1:
# ADD/SUB/SLL/SRL/SRA/SLLV/SRLV/SRAV/AND/OR/XOR/NOR/  
# SLT															12				
# 2. Subset 2:
# ADDI/ANDI/ORI/XORI/LUI/SLTI									6
# 3. Subset 3:
# LB/LH/LW/SB/SH/SW 											6
# 4. Subset 4:
# BEQ/BNE/BGEZ/BGTZ/BLEZ/BLTZ									6
# 5. Subset 5:
# J/JAL/JR/JALR													4
# 6. Subset 6:
# MULT/DIV/MFLO/MFHI/MTLO/MTHI									6
# 																40
##################################################################
### Make sure following Settings :
# Settings -> Memory Configuration -> Compact, Data at address 0
# Settings -> Delayed branching

	.org 0x0
	.set noat
	.set noreorder			#不进行指令调度
	.set nomacro
	.global __start
__start:
	# 注意，MIPS编译时，会将rs和rt的二进制位置互换，写法上是rt,rs，指令码是opcode rs rt(写入rt)
	# 用ori指令作为开始标志
	# start code
	# ori $0, $0, 0x0000
	# 3400 0000
	# 此处开始书写代码
	.org 0x0000
	ori $0, $0, 0x0000
	
	# 真正的代码
	##################
	# Test Subset 2  #
	ori $v0, $0, 0x1234
	lui $v1, 0x9876
	addi $a0, $v0, 0x3456
	addi $a1, $v1, -1024
	xori $a2, $v0, 0xabcd
	slti $a1, $a0, 0x34
	slti $a1, $v0, -1
	andi $a3, $a2, 0x7654
	slti $t0, $v1, 0x1234 
	
	
	##################
	# Test Subset 1  #
	sub $t0, $v1, $v0
	xor $t1, $t0, $v1
	add $t2, $t1, $t0
	add $t2, $t2, $v0
	sub $t3, $t2, $v1
	nor $t4, $t3, $t2
	or  $t5, $t3, $t2
	and $t6, $t3, $t2
	slt $s3, $t5, $t4
	slt $s4, $t5, $t4
	
	### Test for shift
	sll $t0, $t0, 3
	srl $t1, $t0, 16
	sra $t2, $t0, 29
	addi $t3, $0, 0x3410


	# end code
	# 3400 0000 3400 0000
	ori $0, $0, 0x0000
	ori $0, $0, 0x0000