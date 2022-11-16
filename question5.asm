.data  
	# Declaring label names which are then used to prompt inputs and results
	strInput: .space 52 #50 character bytes for the string and two extra bytes for \n and \0 at the end
	
	# converted string (converted to uppercase and remove whitespaces) with 52 white spaces as a buffer.
	checkStr:	.asciiz "                                                    "
	
	enterStr: .asciiz "Enter a valid string(without special characters):"
	invalidPrompt: .asciiz "\nInvalid string entered."
	palindromePrompt: .asciiz "\nThe entered string is a palindrome."
	notpalindromePrompt: .asciiz "\nThe entered string is not a palindrome."
.text

main: #main procedure which recieves the input
	li $v0, 4
	la $a0, enterStr
	syscall
	
	li $v0, 8
	la $a0, strInput
	li $a1, 52
	syscall
lowerConvert: #procedure to convert all the characters of the string to uppercase
	li $t0, 0 #temporary register $t0 acts as a counter
	Lowloop:
		lb $s0, strInput($t0) # storage register $s0 stores the value at the counter's index
		beqz, $s0, invalidcheck # if the character stored in $s0 is null then jump to invalid check
		blt $s0, 65, lowercase # if the character stored in $s0 is less than 65 then jump to lowercase
		bgt $s0, 90, lowercase # if the character stored in $s0 is greater than 90 then jump to lowercase
		beq $s0, 32, lowercase # if the character stored in $s0 is not a white space then jump to lowercase
		addi $s0, $s0, 32 # if the character stored in $s0 is an upper case character, so add 32 to it to make it lowercase.
		sb $s0, strInput($t0) # The converted lower case character is then stored in the counter's index of the string input 
	lowercase:
		addi, $t0, $t0, 1 # counter value is incremented
		j Lowloop # jumps back to the start of the Lowloop
invalidcheck: # procedure that checks if a special character has been entered in the input string
	li, $t0, 0 # temporary register $t0 acts as a counter
	strLoop: 
		lb, $s0, strInput($t0)
		beq, $s0, 10, findlastCharacter
		beq, $s0, 32, increment
		blt $s0, 97, special
		bgt $s0, 122, special
		addi $t0, $t0, 1
		j strLoop
	increment:
		addi $t0, $t0,1
		j strLoop
	special:
		li $v0, 4
		la $a0, invalidPrompt
		syscall
		
		j main

		
findlastCharacter:
	la $t1, strInput
	lastCharacterLoop:
		lb $s2, ($t1)
		beq $s2, $zero , exitlastCharacterLoop
		addi $t1, $t1, 1
		j lastCharacterLoop
	exitlastCharacterLoop:
		addi $t1, $t1, -2
		move $s2, $t1
remleadspace:
	la $s1, strInput
	loop:
		lb $t4, ($s1)
		bne $t4, 32, remTrailspace
		addi $s1,$s1,1
		j loop
remTrailspace:
	lb $t3, ($s2)
	bne $t3, 32, palindrome
	subi $s2,$s2,1
	j remTrailspace
palindrome:# procedure to check whether the input string is a palindrome or not
	
	palindromeLoop:
		bge $s1, $s2, isPalindrome
		lb $t2, ($s1)
		lb $t3, ($s2)
		bne $t2, $t3, notPalindrome
		addi, $s1, $s1, 1
		subi, $s2, $s2, 1
		j palindromeLoop
isPalindrome:
	li $v0, 4
	la $a0, palindromePrompt
	syscall
	j exit
notPalindrome:
	li $v0, 4
	la $a0, notpalindromePrompt
	syscall
	j exit
exit:
	 
		
		
	
		
		
	
	
	
