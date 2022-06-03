#1st step: make dinosaur appear 

#dino width = 50
#dino height = 60

addi $r1, $r0, 20000000003

start_game_loop:
addi $r1, $r1, -1
blt $r1, $r3, 1
j start_game_loop

addi $r28, $r0, 3 #number of lives register
addi $r27, $r0, -4 #initial game velocity

start_game:

add $r0, $r0, $r0
addi $r7, $r0, 1 #register to start score
addi $r16, $r0, 240 #dino x-coordinate (left) 
addi $r17, $r0, 320 #dino y-coordinate (bottom)

addi $r14, $r0, 1500 #obstacle x-coordinate
addi $r15, $r0, 320 #obstacle y-coordinate

addi $r18, $r0, 0 #counter for jump loop
addi $r19, $r0, -209 #dino jump height (for ascend)
addi $r21, $r0, -5 #constant -5 (for descend)
addi $r23, $r0, 45 #constant 45
addi $r3, $r0, 4 #constant 4 -- obstacle count for increasing game velocity by 1


addi $r20, $r0, 0 #button_pressed status register 
addi $r22, $r0, 0 #screedEnd status register
addi $r24, $r0, 0 #collision status register
addi $r25, $r0, 0 #random obstacle size status register clk and count of obstacles that passed
addi $r26, $r0, 0 #pause_game status register - it is a switch

#-----------------------GAME LOOP---------------------------------

game_loop: 

bne $r0, $r20, 5 # --> button is pressed! go to jump section

blt $r26, $r3, 1
jal pause_game 
jal check_collision
jal move_obstacle
j game_loop
j button_pressed

#--------------------JUMP SECTION--------------------------------------------------
button_pressed: 

ascend: 

blt $r26, $r3, 1
jal pause_game
add $r14, $r14, $r27
addi $r17, $r17, -10  #jump 10 pixels per frame
addi $r18, $r18, -10
jal check_collision

not_ready_to_update_ascend:

blt $r0, r22, 1 #r22 > 0 --> ready for next frame

j not_ready_to_update_ascend

#if got here, register received signal that screenEnd = 1, so ready to update frame

addi $r22, $r0, 0 #reset screenEnd register
blt $r18, $r19, 1 #r18<r19 --> check if dino has reached max jump height, go to descend
j ascend

j descend

descend:

blt $r26, $r3, 1
jal pause_game
add $r14, $r14, $r27
addi $r17, $r17, 5  #fall 5 pixels per frame
addi $r18, $r18, 5
jal check_collision

not_ready_to_update_descend:

blt $r0, $r22, 1 #r22 > 0 --> ready for next iteration
j not_ready_to_update_descend

addi $r22, $r0, 0
blt $r21, $r18, 1 #r18 = 0 --> dino has reached ground, clear button register and go back to game loop
j descend

addi $r20, $r0, 0 #clear button register
j game_loop

#--------------------------------------------------------------------------------------

#----------------------OBSTACLE STUFF--------------------------------------------------
move_obstacle:

blt $r14, $r23, reset_obstacle_coord 
blt $r3, $r25, increase_velocity
add $r14, $r14, $r27

not_ready_to_update_obstacle:

blt $r0, $r22, 1
j not_ready_to_update_obstacle

addi $r22, $r0, 0
jr $r31

reset_obstacle_coord:

addi $r14, $r0, 680
addi $r25, $r25, 1
j move_obstacle

increase_velocity:

addi $r27, $r27, -1
addi $r25, $r0, 0
j move_obstacle

#--------------------------------------------------------------------------------------

check_collision:

bne $r24, $r0, 1
jr $r31
addi $r28, $r28, -1
j check_lives

check_lives: 

bne $r28, $r0, 1
j game_over
j start_game

pause_game:

blt $r26, $r3, 1
j pause_game
jr $r31

game_over:

j game_over
#r28 = 0 
