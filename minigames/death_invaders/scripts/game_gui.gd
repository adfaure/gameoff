extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _draw():
	#draw_line(Vector2(25, 130), Vector2(625, 130), Color(255, 255, 255), 5)
	
	var v_pos = get_node("Control").get_pos()
	var v_rect_size = get_node("Control/Viewport").get_rect().size
	
	
	draw_line(Vector2(v_pos.x - 2.5, v_pos.y), 
	Vector2(v_pos.x + v_rect_size.width, v_pos.y), 
	Color(255, 255, 255), 5)
	draw_line(Vector2(v_pos.x + v_rect_size.width, v_pos.y - 2.5), 
	Vector2(v_pos.x + v_rect_size.width, v_pos.y + v_rect_size.height), 
	Color(255, 255, 255), 5)
	draw_line(Vector2(v_pos.x + v_rect_size.width + 2.5, v_pos.y + v_rect_size.height),
	Vector2(v_pos.x, v_pos.y + v_rect_size.height), 
	Color(255, 255, 255), 5)
	draw_line(Vector2(v_pos.x, v_pos.y + v_rect_size.height + 2.5), 
	Vector2(v_pos.x, v_pos.y), 
	Color(255, 255, 255), 5)
	
	
func _ready():
	var score = get_node("Control/Viewport/game").get_score()
	get_node("score").set_text(String(score))
	
	set_process_input(true)
	set_fixed_process(true)
	

func _fixed_process(delta):
	var score = get_node("Control/Viewport/game").get_score()
	get_node("score").set_text(String(score))
	
	if get_node("Control/Viewport/game").is_over() :
		get_node("game_over").show()
	
