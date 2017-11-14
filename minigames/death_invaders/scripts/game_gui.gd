extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _draw():
	pass;

func _ready():
	var score = get_node("Control/Viewport/game").get_score()
	get_node("score").set_text(String(score))
	set_fixed_process(true)
	

func _fixed_process(delta):
	var score = get_node("Control/Viewport/game").get_score()
	get_node("score").set_text(String(score))
	
	if get_node("Control/Viewport/game").is_over() :
		get_node("game_over").show()
		get_node("insert_coin").show()
	
