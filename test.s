add $r0, $r0, $r0
addi $r16, $r0, 240 #dino x-coordinate (center) 
addi $r17, $r0, 320 #dino y-coordinate (bottom)

addi $r18, $r0, 0 #counter for jump loop
addi $r19, $r0, 29 #dino jump height
addi $r21, $r0, 1 #constant 1

addi $r20, $r0, 0 #r20 sees if button is pressed - if pressed r20 != 0
addi $r22, $r0, 0 #screedEnd status register

#2nd step: make dinosaur jump still

game_loop: 

#bne $r0, $r20, 1 #r20 != 0 --> button is pressed! go to jump loop

j game_loop