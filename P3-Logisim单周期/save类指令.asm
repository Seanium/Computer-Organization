lui $t1, 0x1234
ori $t1, 0x5678

sw $t1, 0($0)
sb $t1, 5($0)
sb $t1, 4($0)
sh $t1, 2($0)
sh $t1, 0($0)