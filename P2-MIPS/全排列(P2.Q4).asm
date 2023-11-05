.macro save(%n)
	sw %n, 0($sp)
	addi $sp, $sp, -4
.end_macro

.macro load(%n)
	addi $sp, $sp, 4
	lw %n, 0($sp)
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
	symbol: .space 28
	array: .space 28
	space: .asciiz " "
	enter: .asciiz "\n"
.text

##################### input n
li $v0, 5
syscall
move $s0, $v0 # $s0 = n

##################### call fullarray(t8)
li $a1, 0
jal fullarray # FullArray(0);

##################### end
li $v0, 10
syscall

##################### fullarray(t8)
fullarray:
save($ra)
save($t0)
save($t8)

move $t8, $a1

blt $t8, $s0, if_end
#if (t8 >= n)
	li $t1, 0 # $t1 = j
	for:
	beq $t1, $s0, for_end
	
	sll $t2, $t1, 2 # $t2 = j*4
	lw $a0, array($t2)
	li $v0, 1
	syscall
	printspace

	addi $t1, $t1, 1
	j for
	for_end:
	
	printenter
	j load
	
if_end:
	li $t0, 0 #t0 = i
	for2:
	beq $t0, $s0, for2_end
	
	sll $t1, $t0, 2 # $t1 = i*4
	lw $s2, symbol($t1) # $s2 = symbol[i]
	bnez $s2, else2
	#if(symbol[i]==0)
		addi $t2, $t0, 1	# $t2 = i+1
		sll $t3, $t8, 2		# $t3 = t8*4
		sw $t2, array($t3)	# array[t8] = i+1
		
		sll $t1, $t0, 2		# $t1 = i*4
		li $t4, 1			# $t4 = 1
		sw $t4, symbol($t1)	# symbol[i] = 1
		
		addi $a1, $t8, 1	# a1 = t8 + 1;
		jal fullarray
		
		sll $t1, $t0, 2		# $t1 = i*4
		li $t4, 0			#t4 = 0
		sw $t4, symbol($t1)	# symbol[i] = 0
	
	else2:
	
	addi $t0, $t0, 1
	j for2
	for2_end:
	
load:

load($t8)
load($t0)
load($ra)

jr $ra
