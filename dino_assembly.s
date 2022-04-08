#1st step: make dinosaur appear 

#dino width = 50
#dino height = 60

addi $r16, $r0, 240 #dino x-coordinate (center) 
addi $r17, $r0, 320 #dino y-coordinate (bottom)
addi $r18, $r0, 0 #counter for jump loop
addi $r19, $r0, 29 #dino jump height
addi $r20, $r0, 0 #r20 sees if button is pressed - if pressed r20 != 0
addi $r21, $r0, 1 #constant 1

#2nd step: make dinosaur jump still

game_loop: 

bne $r20, $r0, 1 #if r20 != 0 --> dino should jump, so update coordinates
j button_pressed
j game_loop

button_pressed: 

ascend: 

addi $r17, $r17, 1  
addi $r18, $r18, 1

blt $r19, $r18, 2
j ascend;
j descend

descend:

addi $r17, $r17, -1  
addi $r18, $r18, -1

blt $r18, $r21, 2
j descend
addi $r20, $r20, -1 #clear button register
j game_loop


