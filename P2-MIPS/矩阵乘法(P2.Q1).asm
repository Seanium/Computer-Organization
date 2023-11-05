######################### ans=(i*n+j)*4
.macro getindex(%ans, %n, %i, %j)
	mul %ans, %i, %n
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.data
	A: .word 0: 64
	B: .word 0: 64
	C: .word 0: 64
	space: .asciiz " "
	enter: .asciiz "\n"
	
.text
######################### input n
li $v0, 5
syscall
move $s0, $v0 # $s0 = n

######################### input A
li $t0, 0 # $t0 = i
in_i:
beq $t0, $s0, in_i_end

li $t1, 0 # $t1 = j
in_j:
beq $t1, $s0, in_j_end

getindex($t2, $s0, $t0, $t1)  # $t2 = &A[i][j]
li $v0, 5
syscall
sw $v0, A($t2) # A[i][j] = $v0

addi $t1, $t1, 1
j in_j
in_j_end:

addi $t0, $t0, 1
j in_i
in_i_end:

######################### input B
li $t0, 0 # $t0 = i
in_i_2:
beq $t0, $s0, in_i_end_2

li $t1, 0 # $t1 = j
in_j_2:
beq $t1, $s0, in_j_end_2

getindex($t2, $s0, $t0, $t1)  # $t2 = &B[i][j]
li $v0, 5
syscall
sw $v0, B($t2) # B[i][j] = $v0

addi $t1, $t1, 1
j in_j_2
in_j_end_2:

addi $t0, $t0, 1
j in_i_2
in_i_end_2:

###################### cal
li $t0, 0 # $t0 = i
cal_i:
beq $t0, $s0, cal_i_end

li $t1, 0 # $t1 = j
cal_j:
beq $t1, $s0, cal_j_end

li $s4, 0 # $ reset $s4

li $t2, 0 # $t2 = k
cal_k:
beq $t2, $s0, cal_k_end

getindex($t3, $s0, $t0, $t2) # $t3 = &A[i][k]
getindex($t4, $s0, $t2, $t1) # $t4 = &B[k][j]
lw $s1, A($t3) # s1 = A[i][k]
lw $s2, B($t4) # s2 = B[k][j]
mul $s3, $s1, $s2 # $s3 = $s1 * $s2
add $s4, $s4, $s3 # $s4 = $s4 + $s3
getindex($t5, $s0, $t0, $t1) # $t5 = &C[i][j]
sw $s4, C($t5) # C[i][j] = $s4

addi $t2, $t2, 1
j cal_k
cal_k_end:

addi $t1, $t1, 1
j cal_j
cal_j_end:

addi $t0, $t0, 1
j cal_i
cal_i_end:

######################### output C
li $t0, 0
out_i:
beq $t0, $s0, out_i_end


li $t1, 0
out_j:
beq $t1, $s0, out_j_end

getindex($t2, $s0, $t0, $t1) # $t2 = &C[i][j]
lw $a0, C($t2) # $a0 = C[i][j]
li $v0, 1
syscall

la $a0, space # print " "
li $v0, 4
syscall

addi $t1, $t1, 1
j out_j
out_j_end: 

la $a0, enter # print "\n"
li $v0, 4
syscall

addi $t0, $t0, 1
j out_i
out_i_end:

######################### end
li $v0, 10
syscall