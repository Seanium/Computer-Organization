######################### ans=(i*n+j)*4
.macro getindex(%ans, %i, %j, %n)
	mul %ans, %i, %n
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.macro readint(%n)
	li $v0, 5
	syscall
	move %n, $v0
.end_macro

.macro printint(%n)
	move $a0, %n
	li $v0, 1
	syscall
.end_macro

.macro printspace
	la $a0, space
	li $v0, 4
	syscall
.end_macro

.macro printenter
	la $a0, enter
	li $v0, 4
	syscall
.end_macro

.data
	A: .space 400
	B: .space 400
	C: .space 400
	space: .asciiz " "
	enter: .asciiz "\n"
	
.text
######################### input m1, n1, m2, n2
readint($s0) # $s0 = m1
readint($s1) # $s1 = n1
readint($s2) # $s2 = m2
readint($s3) # $s3 = n2

######################### cal m3, n3
sub $s4, $s0, $s2 # $s4 = m3, m3 = m1 - m2 + 1
addi $s4, $s4, 1
sub $s5, $s1, $s3 # $s5 = n3, n3 = n1 - n2 + 1
addi $s5, $s5, 1

######################### input A
li $t0, 0
A_i:
beq $t0, $s0, A_i_end

li $t1, 0
A_j:
beq $t1, $s1, A_j_end

getindex($t2, $t0, $t1, $s1) #$t2 = &A[i][j]
readint($v0)
sw $v0, A($t2) # A[i][j] = $v0

addi $t1, $t1, 1
j A_j
A_j_end:

addi $t0, $t0, 1
j A_i
A_i_end:

######################### input B
li $t0, 0
B_i:
beq $t0, $s2, B_i_end

li $t1, 0
B_j:
beq $t1, $s3, B_j_end

getindex($t2, $t0, $t1, $s3) #$t2 = &B[i][j]
readint($v0)
sw $v0, B($t2) # B[i][j] = $v0

addi $t1, $t1, 1
j B_j
B_j_end:

addi $t0, $t0, 1
j B_i
B_i_end:

######################### cal convolution
li $t0, 0
cal_i:
beq $t0, $s4, cal_i_end

li $t1, 0
cal_j:
beq $t1, $s5, cal_j_end

li $s6, 0 # reset $s6

li $t2, 0
cal_k:
beq $t2, $s2, cal_k_end

li $t3, 0
cal_l:
beq $t3, $s3, cal_l_end

add $t4, $t0, $t2 # $t4 = i+k
add $t5, $t1, $t3 # $t5 = j+l
getindex($t6, $t4, $t5, $s1) # $t6 = &A[i+k][j+l]
getindex($t7, $t2, $t3, $s3) # $t7 = &B[k][l]
getindex($t8, $t0, $t1, $s5) # $t8 = &C[i][j]
lw $a1, A($t6) # $a1 = A[i+k][j+l]
lw $a2, B($t7) # $a2 = B[k][l]
mul $t9, $a1, $a2 # $t9 = A[i+k][j+l] * B[k][l]
add $s6, $s6, $t9
sw $s6, C($t8)

addi $t3, $t3, 1
j cal_l
cal_l_end:

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
beq $t0, $s4, out_i_end

li $t1, 0
out_j:
beq $t1, $s5, out_j_end

getindex($t2, $t0, $t1, $s5) # $t2 = &C[i][j]
lw $a0, C($t2) # $a0 = C[i][j]
printint($a0)
printspace

addi $t1, $t1, 1
j out_j
out_j_end: 

printenter

addi $t0, $t0, 1
j out_i
out_i_end:

######################### end
li $v0, 10
syscall