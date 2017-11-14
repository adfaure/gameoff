extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var RUN_SPEED = 30
export var WALK_SPEED = 10
export var BASE_SPEED = 10

var run = false

func _ready():
    set_process_input(true);
    set_fixed_process(true);
    pass

func _fixed_process(delta):
	var boost = BASE_SPEED
	
	var input_dir = Vector2(0, 0);
	if Input.is_action_pressed("ui_right"): input_dir += Vector2(1,0);
	if Input.is_action_pressed("ui_left"): input_dir += Vector2(-1,0);
	if Input.is_action_pressed("ui_run"): run = true
	
	var animation
	if (input_dir.x > 0) :
		if run :
			animation = "run"
			boost *= RUN_SPEED
		else :
			animation = "walk"
			boost *= WALK_SPEED
	else :
		animation = "idle";
		
	set_pos(get_pos() + input_dir * boost * delta)
	
	var anim = find_node("Animation")
	var current = anim.get_current_animation()
	if current != animation:
		anim.play(animation);
		
	
	