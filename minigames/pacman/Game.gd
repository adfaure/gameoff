extends Node2D

onready var map = self.get_node("Map")
onready var pac = self.get_node("Pac")
onready var camera = self.get_node("Camera")

var shift = Vector2(32, 32)
const MOTION_SPEED = 512 # Pixels/second
var direction = Vector2(0, 0)

var wainting_dir = Vector2(0, 0)

var velocity = Vector2()
var target_pos = Vector2()
var last_pos = Vector2()


func _ready():
	target_pos = pac.get_pos()
	scale_camera()
	pac.get_node("AnimationPlayer").play("idle")
	set_fixed_process(true)

func scale_camera():
	#camera.make_current()
	var dims = map.calculate_tilemap_size()	
	var width = dims.width * dims.cell_size.x
	var height = dims.height * dims.cell_size.y
	
	#camera.set_pos(Vector2(width/2, height/2))

func pacpos_for_pos(pos):
	var grid_pos = map.map_to_world(pos)
	return grid_pos + shift

func _fixed_process(delta):	
	handle_input()
	var left_dist = target_pos.distance_to(pac.get_pos())
	velocity = delta * MOTION_SPEED * direction
	# print("dist->", velocity.length(), "\tleft->", left_dist ,"\tpacpos->", pac.get_pos(), "\ttarget->", target_pos)
	if velocity.length() > left_dist:
		#bug move_to seems to ignore scaling
		pac.move_to(target_pos * get_scale())
	else:
		pac.move(velocity * get_scale())

	if pac.get_pos() == target_pos:
		process_input()
		last_pos = target_pos
		var next_grid_pos = map.world_to_map(pac.get_pos()) + direction
		
		if map.get_cell(next_grid_pos.x, next_grid_pos.y) != -1:
			target_pos = pac.get_pos() #Pas bouger
		else:
			target_pos = pacpos_for_pos(map.world_to_map(pac.get_pos()) + direction)

	elif wainting_dir != direction && wainting_dir != Vector2() && wainting_dir.dot(direction) != 0:
			direction = wainting_dir
			var tmp
			tmp = target_pos
			target_pos = last_pos
			last_pos = tmp
			pac.set_orientation(direction)
			wainting_dir = Vector2()

func can_turn(input_direction):
	var grid_pos = map.world_to_map(pac.get_pos()) + input_direction
	if map.get_cell(grid_pos.x, grid_pos.y) != -1:
		return false
	return true

func process_input():
	var temp_dir = direction
	# We reset the dir
	if can_turn(wainting_dir) and wainting_dir != Vector2():
		direction = wainting_dir
		pac.set_orientation(direction)
		wainting_dir = Vector2()

func handle_input():
	if (Input.is_action_pressed("move_up")):
		wainting_dir = Vector2(0, -1)
	elif (Input.is_action_pressed("move_down")):
		wainting_dir = Vector2(0, 1)
	elif (Input.is_action_pressed("move_left")):
		wainting_dir = Vector2(-1, 0)
	elif (Input.is_action_pressed("move_right")):
		wainting_dir = Vector2(1, 0)
