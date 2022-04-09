#1st step: make dinosaur appear 

#dino width = 50
#dino height = 60

addi $r16, $r0, 240 #dino x-coordinate (center) 
addi $r17, $r0, 320 #dino y-coordinate (bottom)

addi $r18, $r0, 0 #counter for jump loop
addi $r19, $r0, 29 #dino jump height
addi $r21, $r0, 1 #constant 1

addi $r20, $r0, 0 #r20 sees if button is pressed - if pressed r20 != 0
addi $r22, $r0, 0 #screedEnd status register

#2nd step: make dinosaur jump still

game_loop: 

blt $r0, $r20, 2 #r20 > 0 --> button is pressed! go to jump loop

j game_loop
j button_pressed

button_pressed: 

ascend: 

addi $r17, $r17, 1  
addi $r18, $r18, 1

not_ready_to_update_ascend:

blt $r0, r22, 2 #r22 > 0 --> ready for next iteration

j not_ready_to_update_ascend


blt $r19, $r18, 2 #29<r18 --> dino has reached max jump height, go to descend
j ascend;
j descend

descend:

addi $r17, $r17, -1  
addi $r18, $r18, -1

not_ready_to_update_descend:

blt $r0, $r22, 2 #r22 > 0 --> ready for next iteration
j not_ready_to_update_descend

blt $r18, $r21, 2 #r18 = 0 --> dino has reached ground, clear button register and go back to game loop
j descend

addi $r20, $r20, -1 #clear button register
j game_loop


