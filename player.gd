extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var RUN_SPEED = 30
export var WALK_SPEED = 10
export var BASE_SPEED = 10


var isFlipped = false

func _ready():
    set_process_input(true);
    set_fixed_process(true);
    pass

func _fixed_process(delta):
	var boost = BASE_SPEED
	var run = false
	
	var input_dir = Vector2(0, 0);
	if Input.is_action_pressed("ui_right"): input_dir += Vector2(1,0);
	if Input.is_action_pressed("ui_left"): input_dir += Vector2(-1,0);
	if Input.is_action_pressed("ui_run"): run = true
	
	var animation
	if (input_dir.x != 0) :
		if run :
			animation = "run"
			boost *= RUN_SPEED
		else :
			animation = "walk"
			boost *= WALK_SPEED
	else :
		animation = "idle";

	var nextPos = get_pos() + input_dir * boost * delta
	nextPos.x = max(0, nextPos.x)
	var maxX = get_parent().find_node("floor").get_region_rect().size.x
	nextPos.x = min(maxX, nextPos.x)
	set_pos(nextPos)
	
	var anim = find_node("Animation")
	var current = anim.get_current_animation()
	if current != animation:
		anim.play(animation);
	
	var scale=get_scale()
	if (input_dir.x < 0 && !isFlipped) ||  (input_dir.x > 0 && isFlipped) :
		set_scale(Vector2(-scale.x,scale.y))
		isFlipped = not isFlipped
	
	