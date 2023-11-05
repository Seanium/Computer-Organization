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

.macro getindex(%res, %i, %j) # res = (i*8+j)*4
	mul %res, %i, 8
	add %res, %res, %j
	mul %res, %res, 4
.end_macro

.macro save(%n)
	sw %n, 0($sp)
	addi $sp, $sp, -4
.end_macro

.macro load(%n)
	addi $sp, $sp, 4
	lw %n, 0($sp)
.end_macro

.data
	map: .space 256
	vis: .space 256
	mx: .word 0, 0, 1, -1
	my: .word 1, -1, 0, 0
	
.text

readint($s0)		# n
readint($s1)		# m scanf("%d %d", &n, &m);

li $t0, 0			# i
for1:
beq $t0, $s0, for1_end

	li $t1, 0			# j
	for2:
	beq $t1, $s1, for2_end
	
		readint($t3)
		getindex($t4, $t0, $t1)
		sw $t3, map($t4)		# scanf("%d", &map[i][j]);
	
	addi $t1, $t1, 1
	j for2
	for2_end:

addi $t0, $t0, 1
j for1
for1_end:

readint($s2)		# x1
readint($s3)		# y1
readint($s4)		# x2
readint($s5)		# y2 scanf("%d %d %d %d", &x1, &y1, &x2, &y2);

addi $s2, $s2, -1	# x1 -= 1;
addi $s3, $s3, -1	# y1 -= 1;
addi $s4, $s4, -1	# x2 -= 1;
addi $s5, $s5, -1	# y2 -= 1;

getindex($t0, $s2, $s3)
li $t1, 1
sw $t1, vis($t0)			# vis[x1][y1] = 1;

move $a1, $s2		# a1 = x1;
move $a2, $s3		# a2 = y1;
jal dfs				# dfs(a1, a2);

printint($s6)

li $v0, 10			# end
syscall

dfs:
save($ra)
save($t8)
save($t9)
save($t6)
save($t7)
save($t0)
save($t1)

move $t8, $a1
move $t9, $a2

####################################################
bne $t8, $s4, if1_end
	bne $t9, $s5, if1_end			# if (x == x2 && y == y2)
		addi $s6, $s6, 1				# res++;
		j load							# return;
if1_end:

####################################################
li $t0, 0			# i
for3:
beq $t0, 4, for3_end

	mul $t6, $t0, 4
	lw $t6, mx($t6)
	add $t6, $t8, $t6			# nx = x + mx[i]
	
	mul $t7, $t0, 4
	lw $t7, my($t7)
	add $t7, $t9, $t7			# ny = y + my[i]
	
	getindex($t1, $t6, $t7)		# $t1 = index([nx][ny])

	bltz $t6, if2_end
		bge $t6, $s0, if2_end
			bltz $t7, if2_end
				bge $t7, $s1, if2_end
					lw $t2, vis($t1)			# $t2 = vis[nx][ny]
					lw $t3, map($t1)			# $t3 = map[nx][ny]
					bnez $t2, if2_end
						bnez $t3, if2_end
							li $t2, 1
							sw $t2, vis($t1)		# vis[nx][ny] = 1;
							move $a1, $t6
							move $a2, $t7			# a1 = nx, a2 = ny;
							jal dfs
							li $t2, 0
							sw $t2, vis($t1)		# vis[nx][ny] = 0;
	if2_end:

addi $t0, $t0, 1
j for3
for3_end:

load:
load($t1)
load($t0)
load($t7)
load($t6)
load($t9)
load($t8)
load($ra)
jr $ra
