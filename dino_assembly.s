#1st step: make dinosaur appear 

#dino width = 50
#dino height = 60

add $r0, $r0, $r0
addi $r16, $r0, 240 #dino x-coordinate (center) 
addi $r17, $r0, 320 #dino y-coordinate (bottom)

addi $r14, $r0, 550 #obstacle x-coordinate
addi $r15, $r0, 320 #obstacle y-coordinate

addi $r18, $r0, 0 #counter for jump loop
addi $r19, $r0, -199 #dino jump height
addi $r21, $r0, -10 #constant -10

addi $r20, $r0, 0 #r20 sees if button is pressed - if pressed r20 != 0
addi $r22, $r0, 0 #screedEnd status register

#2nd step: make dinosaur jump still

game_loop: 

bne $r0, $r20, 1 #r20 != 0 --> button is pressed! go to jump loop

j game_loop
j button_pressed

button_pressed: 

ascend: 

addi $r17, $r17, -10  #jump 3 pixels per frame
addi $r18, $r18, -10

not_ready_to_update_ascend:

blt $r0, r22, 1 #r22 > 0 --> ready for next frame

j not_ready_to_update_ascend

#if got here, register received signal that screenEnd = 1, so ready to update frame

addi $r22, $r0, 0 #reset screenEnd register
blt $r18, $r19, 1 #29<r18 --> check if dino has reached max jump height, go to descend
j ascend

j descend

descend:

addi $r17, $r17, 10  #fall 3 pixels per frame
addi $r18, $r18, 10

not_ready_to_update_descend:

blt $r0, $r22, 1 #r22 > 0 --> ready for next iteration
j not_ready_to_update_descend

addi $r22, $r0, 0
blt $r21, $r18, 1 #r18 = 0 --> dino has reached ground, clear button register and go back to game loop
j descend

addi $r20, $r0, 0 #clear button register
j game_loop


