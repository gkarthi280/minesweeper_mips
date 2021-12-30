# Goutham Karthi
# gkarthi

.text

##############################
# PART 1 FUNCTIONS
##############################


setCell:
    #Define your code here
    ############################################
    
    lb $t0, 0($sp) #gets int BG from stack --INT BG
    
    
    #error checking for row an col
    bltz $a0, setCell_error
    bltz $a1, setCell_error
    bgt $a0, 9, setCell_error
    bgt $a1, 9, setCell_error
    
    #error checking for bg and fg
    blt $t0, 0x00, setCell_error
    blt $a3, 0x00, setCell_error
    bgt $t0, 0x0F, setCell_error
    bgt $a3, 0x0F, setCell_error
    
    j setCell_no_error
         
setCell_error:  #error in arguemnts, returns -1
	li $v0, -1
	j setCell_end
	
setCell_no_error: #no error from inputs
	
	li $t1, 10 #number of clumons
    	mul $t1, $t1, $a0 # row * number of columns
   	add $t1, $t1, $a1 # (row * number of columns + column)
    	sll $t1, $t1, 1 #2*(row * number of columns + column)
    	li $t4, 0xffff0000 #address of array[][]
    	add $t1, $t4, $t1 #base_addr + 2*(row * number of columns + column) --> ADDRESS OF DESIRED CELL
    	
	
	sll $t2, $t0, 4 #shifts bg lefft byt 4 to add the forgeground color
	#li $t2, 8 #1000
	#ori $t2, $t2, 8 #background 4 bytes OR "1000"
	or $t2, $t2, $a3 ##background 4 bytes OR "1" AND FG 3 bytes --> BG/FG COLOR VALUE BYTE
	
	sb $a2, 0($t1) #stores character in array[][] (byte 0)
	sb $t2, 1($t1) #stores bg/fg color byte in array[][] (byte 1)
	li $v0, 0
	j setCell_end
	
setCell_end:
	jr $ra
###########################################






#####################################################
initDisplay:
    #Define your code here
    addi $sp, $sp, -24
    sw $a1, 0($sp) #int BG
    sw $ra, 4($sp)
    sw $a0, 8($sp) #int FG
    li $t0, '\0'
    sw $t0, 12($sp) #null character
    sw $0, 16($sp) #row counter
    sw $0, 20($sp) #col counter
    
initDisplay_row_loop:
	lw $t0, 16($sp) #row
	beq $t0, 10, initDisplay_epilogue_end
	j initDisplay_col_loop

initDisplay_col_loop:
	lw $t1, 20($sp) #col
	beq $t1, 10, initDisplay_increment_row
	lw $a0, 16($sp) #int row
	lw $a1, 20($sp) #int col
	lb $a2, 12($sp) #char character (null)
	lw $a3, 8($sp) #int fg
	jal setCell
	j initDisplay_increment_col
	
initDisplay_increment_col:
	lw $t0, 20($sp)
	addi $t0, $t0, 1 #increment col by 1
	sw $t0, 20($sp)
	j initDisplay_col_loop
	
initDisplay_increment_row:
	lw $t0, 16($sp)
	addi $t0, $t0, 1 #increment row by 1
	sw $t0, 16($sp)
	sw $0, 20($sp) #resets col to 0
	j initDisplay_row_loop
	
initDisplay_epilogue_end:
	lw $a1, 0($sp) #int BG
    	lw $ra, 4($sp)
    	lw $a0, 8($sp) #int FG
    	addi $sp, $sp, 24
   	jr $ra
###############################################






###############################################
win:
    #Define your code here
    	#addi $sp, $sp, -4 #nefore still worked
    	addi $sp, $sp, -8
    	sw $0, 0($sp) #BG color for setCell
    	sw $ra, 4($sp)
    	
    
    	li $a0, 0x0F #FG = white
    	li $a1, 0x00 #BG = black
    	jal initDisplay
    	
    	
    	li $a0, 0 #row = 0 
    	li $a1, 3 #col = 3
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[0][3] = bomb
    	
    	li $a0, 1 #row = 1 
    	li $a1, 3 #col = 3
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[1][3] = bomb
    	
    	li $a0, 2 #row = 2 
    	li $a1, 3 #col = 3
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[2][3] = bomb
    	
    	li $a0, 3 #row = 3 
    	li $a1, 3 #col = 3
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[3][3] = bomb
    	
    	li $a0, 3 #row = 3 
    	li $a1, 4 #col = 4
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[3][4] = bomb
    	
    	li $a0, 3 #row = 3 
    	li $a1, 5 #col = 5
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[3][5] = bomb
    	
    	li $a0, 3 #row = 3 
    	li $a1, 6 #col = 6
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[3][6] = bomb
    	
    	li $a0, 2 #row = 2
    	li $a1, 6 #col = 6
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[2][6] = bomb
    	
    	li $a0, 1 #row = 1
    	li $a1, 6 #col = 6
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[1][6] = bomb
    	
    	li $a0, 0 #row = 0
    	li $a1, 6 #col = 6
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x0B #BG color = yellow
	sw $t0, 0($sp)
	jal setCell
    	############set array[0][6] = bomb
    	
    	
    	
    	li $a0, 5 #row = 5
    	li $a1, 0 #col = 0
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[5][0] = exploding bomb
    	
    	li $a0, 6 #row = 6
    	li $a1, 0 #col = 0
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[6][0] = exploding bomb
    	
    	li $a0, 7 #row = 7
    	li $a1, 0 #col = 0
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[7][0] = exploding bomb
    	
    	li $a0, 8 #row = 8
    	li $a1, 0 #col = 0
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[8][0] = exploding bomb
    	
    	li $a0, 9 #row = 9
    	li $a1, 0 #col = 0
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[9][0] = exploding bomb
    	
    	li $a0, 5
    	li $a1, 4 
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[5][4] = exploding bomb
    	
    	li $a0, 6
    	li $a1, 4 
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[6][4] = exploding bomb
    	
    	li $a0, 7
    	li $a1, 4 
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[7][4] = exploding bomb
    	
    	li $a0, 8
    	li $a1, 4 
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[8][4] = exploding bomb
    	
    	li $a0, 9
    	li $a1, 4 
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[9][4] = exploding bomb
    	
    	li $a0, 8
    	li $a1, 1 
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[8][1] = exploding bomb
    	
    	li $a0, 7
    	li $a1, 2
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[7][2] = exploding bomb
    	
    	li $a0, 8
    	li $a1, 3
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x01 #BG color = red
	sw $t0, 0($sp)
	jal setCell
    	############set array[8][3] = exploding bomb
    	
    	li $a0, 5
    	li $a1, 5
	li $a2, 'F'
	li $a3, 0x0D #FG color = bright magenta
	li $t0, 0x0C #BG color = bright blue
	sw $t0, 0($sp)
	jal setCell
    	############set array[5][5] = flag
    	
    	li $a0, 6
    	li $a1, 5
	li $a2, 'F'
	li $a3, 0x0D #FG color = bright magenta
	li $t0, 0x0C #BG color = bright blue
	sw $t0, 0($sp)
	jal setCell
    	############set array[6][5] = flag
    	
    	li $a0, 7
    	li $a1, 5
	li $a2, 'F'
	li $a3, 0x0D #FG color = bright magenta
	li $t0, 0x0C #BG color = bright blue
	sw $t0, 0($sp)
	jal setCell
    	############set array[7][5] = flag
    	
    	li $a0, 8
    	li $a1, 5
	li $a2, 'F'
	li $a3, 0x0D #FG color = bright magenta
	li $t0, 0x0C #BG color = bright blue
	sw $t0, 0($sp)
	jal setCell
    	############set array[8][5] = flag
    	
    	li $a0, 9
    	li $a1, 5
	li $a2, 'F'
	li $a3, 0x0D #FG color = bright magenta
	li $t0, 0x0C #BG color = bright blue
	sw $t0, 0($sp)
	jal setCell
    	############set array[9][5] = flag
    	
    	
    	
    	
    	li $a0, 5
    	li $a1, 6
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[5][6] = 8
    	
    	li $a0, 6
    	li $a1, 6
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[6][6] = 8
    	
    	li $a0, 7
    	li $a1, 6
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[7][6] = 8
    	
    	li $a0, 8
    	li $a1, 6
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[8][6] = 8
    	
    	li $a0, 9
    	li $a1, 6
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[9][6] = 8
    	
    	li $a0, 6
    	li $a1, 7
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[6][7] = 8
    	
    	li $a0, 7
    	li $a1, 8
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[7][8] = 8
    	
    	li $a0, 5
    	li $a1, 9
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[5][9] = 8
    	
    	li $a0, 6
    	li $a1, 9
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[6][9] = 8
    	
    	li $a0, 7
    	li $a1, 9
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[7][9] = 8
    	
    	li $a0, 8
    	li $a1, 9
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[8][9] = 8
    	
    	li $a0, 9
    	li $a1, 9
	li $a2, '8'
	li $a3, 0x0F #FG color = white
	li $t0, 0x02 #BG color = green
	sw $t0, 0($sp)
	jal setCell
    	############set array[9][9] = 8
  
    	#lw $0, 0($sp) #BG color for setCell
    	lw $ra, 4($sp)
    	#addi $sp, $sp, 4 #before still worked
    	addi $sp, $sp, 8
	jr $ra
###############################################






##############################
# PART 2 FUNCTION
##############################

loadMap:
    #Define your code here
    ############################################
	addi $sp, $sp, -36 ###NEED TO UPDATE###
	sw $ra, 0($sp)
	sw $a0, 4($sp) # string filename
	sw $a1, 8($sp) # byte[] array
	sw $0, 12($sp) # file descriptor
	sw $0, 16($sp) # file content string updated
	sw $0, 20($sp) # string char counter
	sw $0, 24($sp) # coordinate counter
	sw $0, 28($sp) # row
	sw $0, 32($sp) # column
	
	lw $t0, 8($sp) #byte[] array
	li $t1, 0 #counter
	
clear_array_loop:
	beq $t1, 100, clear_array_loop_end
	add $t2, $t0, $t1
	li $t3, 128 #10000000
	sb $t3, 0($t2) #sets every cell to #10000000
	j clear_array_loop_increment
	
clear_array_loop_increment:
	addi $t1, $t1, 1
	j clear_array_loop
	
clear_array_loop_end:
	li $v0, 13 #open file system call
	lw $a0, 4($sp) #filename to open
	li $a1, 0 #flag
	li $a2, 0 #mode
	syscall #opens the file
	
	sw $v0, 12($sp) #file descriptor
	bltz $v0, loadMap_error_end #file cannot be opened
	#file succesfully opened
	
	li $v0, 14 #read file system call
	lw $a0, 12($sp) #file descriptor
	la $a1, buffer #address to read
	li $a2, 1024 #maximum chars to read
	syscall #reads the file
	beq $v0, 0, loadMap_error_end #file is empty (0 characters)
	
	la $t0, buffer #loads file contents into $t0
	sw $t0, 16($sp) #file contents string updated
	
loadMap_error_loop:
	#lw $t0, 16($sp) #file contents string updated
	
	lb $t1, 0($t0) #pos1 (row OR null temriantor)
	sw $t1, 28($sp) #row
	beq $t1, $0, loadMap_error_null #first position = null terminator
	blt $t1, 0x30, loadMap_error_end #first position is less than 0 char, error
	bgt $t1, 0x39, loadMap_error_end #first position is greater than 9 char, error
	lw $t2, 24($sp) #coridnate counter
	addi $t2, $t2, 1
	sw $t2, 24($sp) #coridnate counter ++
	
	lb $t2, 1($t0) #pos2 (space)
	bne $t2, 0x20, loadMap_error_end #second position not equal to a space, error
	
	
	lb $t3, 2($t0) #pos3 (column)
	sw $t3, 32($sp) # column
	blt $t3, 0x30, loadMap_error_end #third position is less than 0 char, error
	bgt $t3, 0x39, loadMap_error_end #third position is greater than 9 char, error
	lw $t4, 24($sp) #coordiante counter
	addi $t4, $t4, 1
	sw $t4, 24($sp) #coordinate coutner ++
	
	lb $t4, 3($t0) #pos4 (newLine)
	bne $t4, 0x0a, loadMap_error_end #if fourth position is not new line /n, error
	
	#All chars of the line are valid
	#row = $t1, column = $t3
	lw $t1, 28($sp) #row
	addi $t1, $t1, -48 
	li $t2, 10 #numCols
	mul $t1, $t1, $t2 #row * numCols(10)
	lw $t3, 32($sp) #column
	addi $t3, $t3, -48
	add $t1, $t1, $t3 #row * numCols(10) + column
	lw $t2, 8($sp) #byte[] array
	add $t2, $t1, $t2 #base_address + (row * numCols(10) + column) ADRESS TO STORE
	lb $t5, 0($t2) #10000000
	ori $t5, $t5, 32 #10100000
	sb $t5, 0($t2) #ors 1000000 with 00100000  -> 10100000
	
	j loadMap_error_increment
	
loadMap_error_null: #if char is null terminator
	lw $t0, 24($sp) # coordiante counter
	li $t1, 2
	div $t0, $t1
	mfhi $t1 #remainder of coordinate count/2
	bnez $t1, loadMap_error_end #if coordiante count is odd, error
	j loadMap_update_adjacent
	
loadMap_error_increment:
	#lw $t0, 16($sp) #file contents string updated
	addi $t0, $t0, 4 #adds four to the file content, next line
	#sw $t0, 16($sp) #updates file contents string
	j loadMap_error_loop
	
loadMap_error_end:
	lw $a0, 12($sp) #file descriptor
	li $v0, 16
	syscall #closes file
	lw $ra, 0($sp)
	lw $a0, 4($sp) # string filename
	lw $a1, 8($sp) # byte[] array
	addi $sp, $sp, 36 ###NEED TO UPDATE###
	li $v0, -1 #returns -1
	jr $ra
	
loadMap_update_adjacent: ###up to here works for a fact !!!	
	lw $a0, 12($sp) #file descriptor
	li $v0, 16
	syscall #closes file
	li $t0, 0
	sw $t0, 28($sp) #row = 0
	sw $t0, 32($sp) #column = 0
	
loadMap_row_loop:
	lw $t0, 28($sp) #row
	beq $t0, 10, loadMap_success_end
	
loadMap_column_loop:
	lw $t1, 32($sp) #column
	beq $t1, 10, loadMap_row_loop_increment
	lw $a0, 28($sp) #row
	lw $a1, 32($sp) #column
	lw $a2, 8($sp) #byte[] arary
	jal find_adjacent_bombs
	li $t0, 10 #numCols
	lw $t1, 28($sp) #row
	mul $t1, $t1, $t0 # (row x numCol(10))
	lw $t0, 32($sp) #column
	add $t1, $t1, $t0 #(row x numCol(10) + column)
	lw $t2, 8($sp) #byte[] array
	add $t1, $t1, $t2 #base_address + (row x numCol(10) + column)
	lb $t3, 0($t1)
	or $t3, $t3, $v0 #adds three bits of adjacent bombs to the value
	sb $t3, 0($t1) #stores number of adjacent bombs into byte[] arrray
	
loadMap_column_loop_increment:
	lw $t0, 32($sp) #column
	addi $t0, $t0, 1
	sw $t0, 32($sp) #column = column + 1
	j loadMap_column_loop

loadMap_row_loop_increment:
	lw $t0, 28($sp) #row
	addi $t0, $t0, 1
	sw $t0, 28($sp) #row = row + 1
	sw $0, 32($sp) #column = 0
	j loadMap_row_loop

loadMap_success_end:
	lw $ra, 0($sp)
	lw $a0, 4($sp) # string filename
	lw $a1, 8($sp) # byte[] array
	addi $sp, $sp, 36 
	li $v0, 0
	jr $ra

find_adjacent_bombs: #finds adjacent bombs and upploads values|
 		#a0 = row
 		#a1 = column
 		#a2 = byte[] array
 		
 	li $t0, 0 #nubmer of adjacent bombs -> $v0
 	beq $a0, 0, row_zero
 	beq $a0, 9, row_nine
 	
 	beq $a1, 0, col_zero
 	beq $a1, 9, col_nine
 	#element is not at the edge
 	li $t5, 10 #numCols
 	
 	# [row-1][column]
 	addi $t1, $a0, -1 #row - 1
	mul $t1, $t1, $t5 # (row-1 x numCol(10))
	add $t1, $t1, $a1 #(row-1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row-1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next1a
 	addi $t0, $t0, 1
 	
next1a:
 	# [row+1][column]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	add $t1, $t1, $a1 #(row+1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next1b
 	addi $t0, $t0, 1
 	
next1b:
 	# [row][column-1]
 	addi $t1, $a1, -1 #column - 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column-1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm-1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next1c
 	addi $t0, $t0, 1
 	
next1c:
 	# [row][column+1]
 	addi $t1, $a1, 1 #column + 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column+1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm+1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next1d
 	addi $t0, $t0, 1
 	
 next1d:
 	# [row+1][column+1]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, 1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next1e
 	addi $t0, $t0, 1
 	
 next1e:
 	# [row-1][column-1]
 	addi $t1, $a0, -1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, -1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next1f
 	addi $t0, $t0, 1
 	
 next1f:
 	# [row+1][column-1]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, -1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next1g
 	addi $t0, $t0, 1
 	
  next1g:
 	# [row-1][column+1]
 	addi $t1, $a0, -1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, 1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, find_adjacent_bombs_end
 	addi $t0, $t0, 1
 	j find_adjacent_bombs_end
 
 	
row_zero:
 	beq $a1, 0, row_col_zero
 	beq $a1, 9, row_zero_col_nine
 	
 	#row = 0, column is between 1-8
 	
 	# [row+1][column]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	add $t1, $t1, $a1 #(row+1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next2a
 	addi $t0, $t0, 1
 
next2a:
 	# [row][column-1]
 	addi $t1, $a1, -1 #column - 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column-1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm-1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next2b
 	addi $t0, $t0, 1
 	
next2b:
 	# [row][column+1]
 	addi $t1, $a1, 1 #column + 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column+1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm+1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next2c
 	addi $t0, $t0, 1
 	
 next2c:
 	# [row+1][column-1]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, -1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next2d
 	addi $t0, $t0, 1
 	
 next2d:
 	# [row+1][column+1]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, 1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, find_adjacent_bombs_end
 	addi $t0, $t0, 1
 	j find_adjacent_bombs_end
 	
 	
 row_col_zero: #row = 0, column = 0
 	# [row+1][column]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	add $t1, $t1, $a1 #(row+1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next3a
 	addi $t0, $t0, 1
 	
next3a:
 	# [row][column+1]
 	addi $t1, $a1, 1 #column + 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column+1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm+1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next3b
 	addi $t0, $t0, 1
 	
 next3b:
 	# [row+1][column+1]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, 1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, find_adjacent_bombs_end
 	addi $t0, $t0, 1
 	j find_adjacent_bombs_end
 	
 row_zero_col_nine: #row = 0, column = 9
 	# [row+1][column]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	add $t1, $t1, $a1 #(row+1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next4a
 	addi $t0, $t0, 1
 
 next4a:
 	# [row][column-1]
 	addi $t1, $a1, -1 #column - 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column-1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm-1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next4b
 	addi $t0, $t0, 1
 	
 next4b:
 	# [row+1][column-1]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, -1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, find_adjacent_bombs_end
 	addi $t0, $t0, 1
 	j find_adjacent_bombs_end
 	
 row_nine:
 	beq $a1, 0, row_nine_col_zero
 	beq $a1, 9, row_col_nine
 	
 	#row = 9, column is between 1-8
 	
 	# [row-1][column]
 	addi $t1, $a0, -1 #row - 1
	mul $t1, $t1, $t5 # (row-1 x numCol(10))
	add $t1, $t1, $a1 #(row-1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row-1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next5a
 	addi $t0, $t0, 1
 	
 	
 next5a:
 	# [row][column-1]
 	addi $t1, $a1, -1 #column - 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column-1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm-1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next5b
 	addi $t0, $t0, 1
 	
next5b:
 	# [row][column+1]
 	addi $t1, $a1, 1 #column + 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column+1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm+1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next5c
 	addi $t0, $t0, 1
 	j next5c
 
next5c:	
	 # [row-1][column-1]
 	addi $t1, $a0, -1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, -1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next5d
 	addi $t0, $t0, 1
 	
 next5d:
 	# [row-1][column+1]
 	addi $t1, $a0, -1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, 1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, find_adjacent_bombs_end
 	addi $t0, $t0, 1
 	j find_adjacent_bombs_end
 	
 row_nine_col_zero: #row = 9, column = 0
 	# [row-1][column]
 	addi $t1, $a0, -1 #row - 1
	mul $t1, $t1, $t5 # (row-1 x numCol(10))
	add $t1, $t1, $a1 #(row-1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row-1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next6a
 	addi $t0, $t0, 1
 	
 next6a:
 	# [row][column+1]
 	addi $t1, $a1, 1 #column + 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column+1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm+1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next6b
 	addi $t0, $t0, 1
 	
 next6b:
 	# [row-1][column+1]
 	addi $t1, $a0, -1 #row - 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, 1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, find_adjacent_bombs_end
 	addi $t0, $t0, 1
 	j find_adjacent_bombs_end
 	
 row_col_nine: #row = 9, column = 9
 	# [row-1][column]
 	addi $t1, $a0, -1 #row - 1
	mul $t1, $t1, $t5 # (row-1 x numCol(10))
	add $t1, $t1, $a1 #(row-1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row-1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next7a
 	addi $t0, $t0, 1
 	
next7a:
	# [row][column-1]
 	addi $t1, $a1, -1 #column - 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column-1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm-1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next7b
 	addi $t0, $t0, 1
 	
 next7b:	
 	# [row-1][column-1]
 	addi $t1, $a0, -1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, -1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, find_adjacent_bombs_end
 	addi $t0, $t0, 1
 	j find_adjacent_bombs_end
	
 		
 col_zero: #row in bwetween 1-8, column = 0
 	# [row-1][column]
 	addi $t1, $a0, -1 #row - 1
	mul $t1, $t1, $t5 # (row-1 x numCol(10))
	add $t1, $t1, $a1 #(row-1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row-1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next8a
 	addi $t0, $t0, 1
 	
 next8a:
 	# [row+1][column]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	add $t1, $t1, $a1 #(row+1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next8b
 	addi $t0, $t0, 1
 	
 next8b:
 	# [row][column+1]
 	addi $t1, $a1, 1 #column + 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column+1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm+1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next8c
 	addi $t0, $t0, 1
 	
 next8c:
 	# [row+1][column+1]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, 1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next8d
 	addi $t0, $t0, 1
 	
 next8d:
 	# [row-1][column+1]
 	addi $t1, $a0, -1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, 1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, find_adjacent_bombs_end
 	addi $t0, $t0, 1
 	j find_adjacent_bombs_end
 
 	
 col_nine: #row in bwetween 1-8, column = 9
 	# [row-1][column]
 	addi $t1, $a0, -1 #row - 1
	mul $t1, $t1, $t5 # (row-1 x numCol(10))
	add $t1, $t1, $a1 #(row-1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row-1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next9a
 	addi $t0, $t0, 1
 	
 next9a:
 	# [row+1][column]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	add $t1, $t1, $a1 #(row+1 x numCol(10) + column)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next9b
 	addi $t0, $t0, 1
 	
 next9b:
 	# [row][column-1]
 	addi $t1, $a1, -1 #column - 1
	mul $t2, $a0, $t5 # (row x numCol(10))
	add $t1, $t2, $t1 #(row x numCol(10) + column-1)
	add $t1, $t1, $a2 #base_address + (row x numCol(10) + columm-1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next9c
 	addi $t0, $t0, 1
 
 next9c:
 	# [row+1][column-1]
 	addi $t1, $a0, 1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, -1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, next9d
 	addi $t0, $t0, 1
 
 next9d:	
 	# [row-1][column-1]
 	addi $t1, $a0, -1 #row + 1
	mul $t1, $t1, $t5 # (row+1 x numCol(10))
	addi $t4, $a1, -1 # column + 1
	add $t1, $t1, $t4 #(row+1 x numCol(10) + column+ 1)
	add $t1, $t1, $a2 #base_address + (row+1 x numCol(10) + column+ 1)
	lb $t2, 0($t1) #current byte
	#li $t3, 32 #100000
	ori $t3, $t2, 32 #100000
	bne $t3, $t2, find_adjacent_bombs_end
 	addi $t0, $t0, 1
 	j find_adjacent_bombs_end
 	
 		
 find_adjacent_bombs_end:
 	move $v0, $t0
 	jr $ra
###############################################

	
		
			
				
					
						
							
								
									
											
	
##############################
# PART 3 FUNCTION
##############################

mapReveal:
    #Define your code here
    addi $sp, $sp, -32 #some value
    sw $0, 0($sp) #int bg for SetCell
    sw $ra, 4($sp)
    sw $a0, 8($sp) #int move_row
    sw $a1, 12($sp) #int move_col
    sw $a2, 16($sp) #int gameStatus
    sw $a3, 20($sp) #byte[] array
    sw $0, 24($sp) #current row
    sw $0, 28($sp) #current column
    #sw $0, 20($sp) #int fg
    
    
    beqz $a2, mapReveal_epilogue_finish #ends function if on-going
    beq $a2, 1, mapReveal_game_won #shows win screen if game is won
    j mapReveal_game_lost  #game lost
    
mapReveal_game_won:
	jal win
	j mapReveal_epilogue_finish
	
mapReveal_game_lost: #need to work on this
	li $a0, 0x0F #FG = white
    	li $a1, 0x00 #BG = black
    	jal initDisplay #sets everything to black bg, white fg
    	
    	#first have to reveal every position in byte[] array (OR 64 -> 1000000)
mapReveal_row_reveal_loop:
	lw $t0, 24($sp) #row
	beq $t0, 10, mapReveal_epilogue_finish
	
mapReveal_column_reveal_loop:
	#if row,col = move_row,move_col
	lw $t1, 24($sp) #row
	lw $t2, 8($sp) #move_row
	beq $t1, $t2, row_eq_move_row
	j not_exploding_bomb
	
row_eq_move_row:
	lw $t1, 28($sp) #col
	lw $t2, 12($sp) #move_col
	beq $t1, $t2, display_exploding_bomb
	j not_exploding_bomb
	
	
display_exploding_bomb: #diplsays exploding bomb
	lw $a0, 24($sp) #row
    	lw $a1, 28($sp) #col
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x09 #BG color = bright
	sw $t0, 0($sp)
	jal setCell
	j mapReveal_column_reveal_loop_increment
    	############set array[row][col] = exploding bomb
	
not_exploding_bomb:
	#row is not equal to 
	lw $t1, 28($sp) #column
	beq $t1, 10, mapReveal_row_reveal_loop_increment
	li $t0, 10 #numCols
	lw $t1, 24($sp) #row
	mul $t1, $t1, $t0 # (row x numCol(10))
	lw $t0, 28($sp) #column
	add $t1, $t1, $t0 #(row x numCol(10) + column)
	lw $t2, 20($sp) #byte[] array
	add $t1, $t1, $t2 #base_address + (row x numCol(10) + column) ##ADDRESS TARGET##
	#lb $t3, 0($t1)
	#ori $t3, $t3, 64 #OR value with 64 -> 1000000, reveal bit
	#sb $t3, 0($t1) #stores value into byte[] arrray
	
	lb $t3, 0($t1)
	#li $t4, 16
	ori $t4, $t3, 16 #10000
	bne $t4, $t3, mapReveal_not_flag
#cell is flagged#code here
	#if bomb, display green flag, else display red flag
	
	lb $t3, 0($t1)
	ori $t4, $t3, 32 #OR value with 32 --> 100000
	bne $t4, $t3, display_red_flag #flagged and not a bomb, red flag
#display green flag, flagged and a bomb
	lw $a0, 24($sp) #row 
    	lw $a1, 28($sp) #col
	li $a2, 'F'
	li $a3, 0x0C #FG color = bright blue
	li $t0, 0x0A #BG color = bright green
	sw $t0, 0($sp)
	jal setCell
	j mapReveal_column_reveal_loop_increment
    	############set array[row][column] = green flag
    	
display_red_flag:
	lw $a0, 24($sp) #row 
    	lw $a1, 28($sp) #col
	li $a2, 'F'
	li $a3, 0x0C #FG color = bright blue
	li $t0, 0x09 #BG color = bright red
	sw $t0, 0($sp)
	jal setCell
	j mapReveal_column_reveal_loop_increment
    	############set array[row][column] = red flag
	
	
mapReveal_not_flag: #cell is not flagged
	lb $t3, 0($t1)
	ori $t4, $t3, 32 #OR valyue with 32 --> 100000
	bne $t4, $t3, mapReveal_display_digit #not a bomb
#element is a bomb
	lw $a0, 24($sp) #row 
    	lw $a1, 28($sp) #col
	li $a2, 'B'
	li $a3, 0x07 #FG color = grey
	li $t0, 0x00 #BG color = black
	sw $t0, 0($sp)
	jal setCell
	j mapReveal_column_reveal_loop_increment
    	############set array[row][column] = bomb
	
mapReveal_display_digit: #not flagged and not a bomb
	lb $t3, 0($t1)
	andi $t4, $t3, 15 #AND value with 15 --> 00001111 -- makes the upper four bits = 0
	beqz $t4, mapReveal_column_reveal_loop_increment #if bottom four bits = 0, pass
#positive digit
	lw $a0, 24($sp) #row
    	lw $a1, 28($sp) #col
    	addi $a2, $t4, 48 #ascii digit
	#li $a2, '8'
	li $a3, 0x0D #FG color = bright magenta
	li $t0, 0x00 #BG color = black
	sw $t0, 0($sp)
	jal setCell
	j mapReveal_column_reveal_loop_increment
    	############set array[row][col] = digit lower four bits
	
mapReveal_column_reveal_loop_increment:
	lw $t0, 28($sp) #column
	addi $t0, $t0, 1
	sw $t0, 28($sp) #column = column + 1
	j mapReveal_column_reveal_loop

mapReveal_row_reveal_loop_increment:
	lw $t0, 24($sp) #row
	addi $t0, $t0, 1
	sw $t0, 24($sp) #row = row + 1
	sw $0, 28($sp) #column = 0
	j mapReveal_row_reveal_loop
    	
mapReveal_epilogue_finish:
	#lw $0, 0($sp)
    	lw $ra, 4($sp)
    	lw $a0, 8($sp) #int move_row
    	lw $a1, 12($sp) #int move_col
    	lw $a2, 16($sp) #int gameStatus
    	lw $a3, 20($sp) #byte[] array
    	addi $sp, $sp, 32  #some value
    	jr $ra

















##############################
# PART 4 FUNCTIONS
##############################

playerMove:
    #Define your code here
    ############################################
    
    	lw $t0, 0($sp) #int bg
    	lw $t1, 4($sp) #int fg
    
	addi $sp, $sp, -36 ###SOME BVALUE
	sw $t0, 0($sp) #BG COLOR
	sw $ra, 4($sp)
	sw $a0, 8($sp) #byte[] array
	sw $a1, 12($sp) #int move_row
	sw $a2, 16($sp) #int move_col
	sw $a3, 20($sp) #char action
	sw $t1, 24($sp) #fg
	sw $0, 28($sp) #row
	sw $0, 32($sp) #col


#error chekcing
	lw $t0, 12($sp) #move_row
	lw $t1, 16($sp) #move_col
	lw $t2, 20($sp) #action
	
	bltz $t0, playerMove_error_finish #if move_row < 0, error
	bltz $t1, playerMove_error_finish #if move_col < 0, error
	bgt $t0, 9, playerMove_error_finish #if move_row > 9, error
	bgt $t1, 9, playerMove_error_finish #if move_col > 9, error
	#row and column are valid
	lw $t0, 12($sp) #row
	li $t1, 10 #numCOls
	mul $t0, $t0, $t1 #row * numCOls
	lw $t1, 16($sp) #col
	add $t0, $t0, $t1 #row * numCOls + col
	lw $t1, 8($sp) #base_address of byte[] array
	add $t0, $t0, $t1 #base_address + (row * numCOls + col) ###DESIRED TRAARGET ADDRESS ---> $T0
	
	
	#error checking for palyer action
	beq $t2, 0x46, playerMove_flag #action = 'F'
	beq $t2, 0x66, playerMove_flag #action = 'f'
	beq $t2, 0x52, playerMove_reveal #action = 'R'
	beq $t2, 0x72, playerMove_reveal #action = 'r'
	j playerMove_error_finish #action != 'F', 'f', 'R', 'r', error

	
playerMove_flag: #action is 'F' or 'f'
	lb $t1, 0($t0)
	ori $t2, $t1, 64 #ORS values with 64 or 1000000
	beq $t1, $t2, playerMove_error_finish #revealed cell has been falgged by player, error
	
	lb $t1, 0($t0)
	ori $t2, $t1, 16 #ORS values with 16 or 10000
	beq $t2, $t1, flag_flagged_cell   #player flags a flagged cell
	#flagging an unflagged cell
	lb $t1, 0($t0)
	ori $t1, $t1, 16 #ORS values with 16 or 10000
	sb $t1, 0($t0) #set flag bit to 1
	
	lw $a0, 12($sp) #row
    	lw $a1, 16($sp) #col
	li $a2, 'F'
	li $a3, 0x0C #FG color = bright blue
	li $t0, 0x07 #BG color = grey
	sw $t0, 0($sp)
	jal setCell
    	############set array[row][col] = flag
	j playerMove_success_finish
	
flag_flagged_cell:
	lb $t1, 0($t0)
	andi $t1, $t1, 15 #set flag bit to 0 -- bit 4
	sb $t1, 0($t0)
	
	lw $a0, 12($sp) #row move_row
    	lw $a1, 16($sp) #col = move_col
	li $a2, '\0' #null character
	lw $a3, 24($sp) #FG color
	#BG color already stored in 0($sp)
	jal setCell
	############set array[row][col] = default bg/fg color
	j playerMove_success_finish
	
	
playerMove_reveal: #action is 'R' or 'r'
	lb $t1, 0($t0)
	ori $t2, $t1, 64 #ORS values with 64 or 1000000
	beq $t1, $t2, playerMove_error_finish #revealed cell has been revealed by player, error
	
	#code for revealing a flagged cell
	lb $t1, 0($t0)
	ori $t2, $t1, 16 #ORS values with 16 or 10000
	beq $t2, $t1, reveal_flagged_cell   #player reveals a flagged cell
	j reveal_next #reaveals an unflagged cell
	
reveal_flagged_cell:
	lb $t1, 0($t0)
	andi $t1, $t1, 15 #set flag bit to 0 -- bit 4
	sb $t1, 0($t0)
	j reveal_next
	
reveal_next:
	lb $t1, 0($t0)
	ori $t2, $t1, 32
	beq $t2, $t1, reveal_exploding_bomb
	#not a bomb, so a regular cell
	lb $t1, 0($t0)
	andi $t1, $t1, 15
	bgtz $t1, reveal_digit
	#digit = 0
	lw $a0, 12($sp) #row move_row
    	lw $a1, 16($sp) #col = move_col
	li $a2, '\0' #null character
	li $a3, 0x0F #FG color = white
	li $t2, 0x00 #BG = black
	sw $t2, 0($sp)
	jal setCell
	j reveal_next1

reveal_next1:
	lw $t0, 12($sp) #row
	li $t1, 10 #numCOls
	mul $t0, $t0, $t1 #row * numCOls
	lw $t1, 16($sp) #col
	add $t0, $t0, $t1 #row * numCOls + col
	lw $t1, 8($sp) #base_address of byte[] array
	add $t0, $t0, $t1 #base_address + (row * numCOls + col) ###DESIRED TRAARGET ADDRESS ---> $T0
	
	lb $t1, 0($t0)
	ori $t1, $t1, 64 #ORS values with 64 or 1000000
	sb $t1, 0($t0) #updates bit 6 bit to 1
	
	lw $a0, 12($sp) #row_move
	lw $a1, 16($sp) #col_move	
	jal revealCells
	j playerMove_success_finish

reveal_exploding_bomb:
	lw $a0, 12($sp) #row
    	lw $a1, 16($sp) #col
	li $a2, 'E'
	li $a3, 0x0F #FG color = white
	li $t0, 0x09 #BG color = bright red
	sw $t0, 0($sp)
	jal setCell
	j reveal_next1
    	############set array[row][col] = exploding bomb
    	
reveal_digit:
	lw $a0, 12($sp) #row
    	lw $a1, 16($sp) #col
    	addi $a2, $t1, 48 #ascii digit
	li $a3, 0x0D #FG color = bright magenta
	li $t0, 0x00 #BG color = black
	sw $t0, 0($sp)
	jal setCell
	#j playerMove_success_finish
	j reveal_next1
    	############set array[row][col] = digit lower four bits

playerMove_error_finish:
	li $v0, -1
	j playerMove_epilogue_finish
	
	
playerMove_success_finish:
	li $v0, 0
	j playerMove_epilogue_finish
	
playerMove_epilogue_finish:	
	#lw $t1, 0($sp) #BG COLOR
	lw $ra, 4($sp)
	lw $a0, 8($sp) #byte[] array
	lw $a1, 12($sp) #int move_row
	lw $a2, 16($sp) #int move_col
	lw $a3, 20($sp) #char action
	#lw $t0, 24($sp) #fg
	addi $sp, $sp, 36 ###SOME BVALUE
	jr $ra
    
    
    #li $v0, -200
    ##########################################
  #  jr $ra












gameStatus:
    #Define your code here
    ############################################
    # DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
    li $t0, 0 #row
    li $t1, 0 #col
    
win_row_loop:    #loop for detecting if game is won (all bombs are flagged  && no non-bombs are flagged) --> next loop if any flagged non-bomb OR unflagged-bomb
	beq $t0, 10, gameStatus_won_finish
	j win_col_loop

win_col_loop:
	beq $t1, 10, win_increment_row
	li $t2, 10 #numCols
	mul $t2, $t2, $t0 #(row * numCols)
	add $t2, $t2, $t1 #(row * numCols + col)
	add $t2, $t2, $a0  #base_address + (row * numCols + col) #Desired Address
	lb $t3, 0($t2) #DESIRED CELL VALUE == $T3	
	
	ori $t4, $t3, 16
	bne $t4, $t3, win_unflagged_cell
	#cell is flagged
	ori $t4, $t3, 32
	bne $t4, $t3, gameStatus_ongoing_or_lost_loop #if flagged cell is NOT bomb, game is not won
	j win_increment_col
	
win_unflagged_cell: #cell is not flagged
	ori $t4, $t3, 32
	beq $t4, $t3,  gameStatus_ongoing_or_lost_loop #if unflagged cell is bomb, game is not won
	j win_increment_col
	
		
win_increment_col:
	addi $t1, $t1, 1 #increment col by 1
	j win_col_loop
	
win_increment_row:
	addi $t0, $t0, 1 #increment row by 1
	li $t1, 0
	j win_row_loop
    
    
gameStatus_ongoing_or_lost_loop:   #loop for detecting if game is lost of ongoing  
	li $t0, 0 #row counter
	li $t1, 0 #col counter
    
gameStatus_row_loop:
	beq $t0, 10, gameStatus_ongoing_finish
	j gameStatus_col_loop

gameStatus_col_loop:
	beq $t1, 10, gameStatus_increment_row
	li $t2, 10 #numCols
	mul $t2, $t2, $t0 #(row * numCols)
	add $t2, $t2, $t1 #(row * numCols + col)
	add $t2, $t2, $a0  #base_address + (row * numCols + col) #Desired Address
	lb $t3, 0($t2) #DESIRED CELL VALUE == $T3	
	
	ori $t4, $t3, 64
	bne $t4, $t3, gameStatus_increment_col #not revealed
	#cell is revealed
	ori $t4, $t3, 32
	beq $t4, $t3, gameStatus_lost_finish #if revealed cell is bomb, game lost
	j gameStatus_increment_col
		
gameStatus_increment_col:
	addi $t1, $t1, 1 #increment col by 1
	j gameStatus_col_loop
	
gameStatus_increment_row:
	addi $t0, $t0, 1 #increment row by 1
	li $t1, 0
	j gameStatus_row_loop
 
    ##########################################
gameStatus_ongoing_finish:
	li $v0, 0
	jr $ra
	
gameStatus_lost_finish:
	li $v0, -1
	jr $ra
	
gameStatus_won_finish:
	li $v0, 1
	jr $ra
	
	
	
	
	
	
	
	

##############################
# PART EC FUNCTIONS
##############################

revealCells:
    #Define your code here
    jr $ra


#################################################################
# Student defined data section
#################################################################
.data
.align 2  # Align next items to word boundary
cells_array: .space 200
buffer: .space 1024


