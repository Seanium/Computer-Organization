.data
	A: .space 80
	
.text
################### input n
li $v0, 5
syscall
move $s0, $v0 # $s0 = n

################### input A
li $t0, 0 # t0 = i
in:
beq $t0, $s0, in_end

li $v0, 12
syscall
move $t1, $v0 # $t1 = char_in

sb $t1, A($t0)

addi $t0, $t0, 1
j in
in_end:

################### res = 1
li $s3, 1 # $s3 = res

################### compare
li $t0, 0
comp:
beq $t0, $s0, comp_end

sub $t1, $s0, $t0 # $t1=$s0-$t0-1 -> j=n-i-1
subi $t1, $t1, 1
lb $s1, A($t0) # $s1 = A[i]
lb $s2, A($t1) # $s2 = A[i]
beq $s1, $s2, else
li $s3, 0
else:

addi $t0, $t0, 1
j comp
comp_end:

################### output res
move $a0, $s3
li $v0, 1
syscall

################### end
li $v0, 10
syscall