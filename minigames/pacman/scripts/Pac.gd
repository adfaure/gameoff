# Contains the player logic
extends KinematicBody2D

const direction = Vector2()
var score = 0

const UP    = Vector2(0, -1)
const RIGHT = Vector2(1, 0)
const DOWN  = Vector2(0, 1)
const LEFT  = Vector2(-1, 0)

func reset():
	set_rotd(0)
	get_node("Sprite").set_flip_h(false)

func increase_score():
	score += 1
	print("eated", score)

func set_orientation(new_dir):
	reset()
	if(new_dir == LEFT):
		get_node("Sprite").set_flip_h(true)
	elif(new_dir == RIGHT):
		get_node("Sprite").set_flip_h(false)
	elif(new_dir == UP):
		set_rotd(90)
	elif(new_dir == DOWN):
		set_rotd(-90)

