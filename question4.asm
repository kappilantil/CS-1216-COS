.data
input_prompt: .asciiz "Enter a positive integer\n"
error: .asciiz " Error! Enter positive interger \n"
naive_msg: .asciiz " Naive way :"
interesting_msg: .asciiz "\nInteresting way: "

.text
main:

#display input msg
la $a0, input_prompt	
li $v0, 4
syscall

#take an input integer
li $v0, 5	
syscall

#moving value of $v0 to $t0
move $t0,$v0	 

bgt $t0, 0 , jump 
la $a0, error		
li $v0, 4

#terminating if negative number	
syscall
li $v0,10
Syscall
jump:			

li $t1,0 	

#Algorithm Implementation
loop:
bge $t1, $t0, end
addi $t1, $t1, 1 	
mul $t2,$t1,$t1		
add $t3, $t3, $t2	
j loop	
end:


#1st method
la $a0, naive_msg		
li $v0, 4	
syscall

li $v0,1	 	
move $a0,$t3	
syscall

#2nd method
addi $t1, $t0, 1	
mul $t2, $t0, 2		
addi $t3, $t2, 1	
mul $t4, $t0, $t1
mul $t5, $t3, $t4
div $t6, $t5, 6 

la $a0, interesting_msg		
li $v0, 4	
syscall

li $v0,1		
move $a0,$t6
syscall

li $v0,10
Syscall