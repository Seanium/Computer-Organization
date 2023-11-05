.data
	A: .space 6000

.text

li $v0, 5
syscall					# scanf("%d", &n);
move $s0, $v0			# $s0 = n

li $s1, 0				# $s1 = len
li $s2, 0				# $s2 = jinwei

li $t0, 1
sw $t0, A($0)			# A[0] = 1

li $t0, 2				# int i = 2
for:
bgt $t0, $s0, for_end	# i <= n

	li $s2, 0				# jinwei = 0;

	li $t1, 0				# int j = 0
	for2:
	addi $t2, $s1, 4		# $t2 = len + 4
	bgt $t1, $t2, for2_end	# j <= len + 4
	
		sll $a1, $t1, 2		# $a1 = j*4
		lw $t3, A($a1)		# $t3 = A[j]
		mul $t3, $t3, $t0	# $t3 = A[j] * i
		add $t3, $t3, $s2	# $t3 = A[j] * i + jinwei;
		
		li $t4, 10			# $t4 = 10
		div $t3, $t4 		# $hi=$t3/10, $lo=$t3%10
		mflo $s2			# jinwei = $t3 / 10;
		mfhi $t4			# $t4 = $t3 % 10
		sw $t4, A($a1)		# A[j] = A[j] % 10;
		
	addi $t1, $t1, 1		# j++
	j for2
	for2_end:
	
	addi $s1, $s1, 4		# len = len + 4;
	
	move $t1, $s1				# int k=len
	for3:
	beqz $t1, for3_end
	
		sll $t2, $t1, 2
		lw $t3, A($t2)
		bnez $t3, else3
			addi $s1, $s1, -1
			j else3_end
		else3:
			j for3_end
		else3_end:
	
	addi $t1, $t1, -1
	j for3
	for3_end:
	
addi $t0, $t0, 1	# i++
j for
for_end:

	move $t1, $s1				# int k=len
	for4:
	beqz $t1, for4_end
	
		sll $t2, $t1, 2
		lw $t3, A($t2)
		bnez $t3, else4
			addi $s1, $s1, -1
			j else4_end
		else4:
			j for4_end
		else4_end:
	
	addi $t1, $t1, -1
	j for4
	for4_end:

move $t0, $s1				# int i = len
for5:
blt $t0, $0, for5_end		# i >= 0

	sll $t1, $t0, 2				# $t1 = i*4
	lw $a0, A($t1)				# $a0 = A[i]
	li $v0, 1
	syscall						# printf("%d", A[i]);
	
addi $t0, $t0, -1			# i--
j for5
for5_end:

################################## end
li $v0, 10
syscall
