extends Node2D

# variables that a editable in the godot GUI
export var PLAYER_SPEED = 200
export var DEADS_SPEED = 50
export var BULLET_SPEED = 200
export var SPAWN_RATE = 0.02

var score
export var over = true

func get_score():
	return score

func is_over():
	return over

func generate_deads(var count = 1):
	var d_scene = load("res://minigames/death_invaders/scenes/dead.tscn")
	var dead = d_scene.instance()
	
	for i in range(count) :
		var dead_size = dead.get_item_rect().size
		var random_height = rand_range(dead_size.height / 2,
			self.get_viewport_rect().size.height - dead_size.height / 2)
		dead.set_pos(Vector2(
			self.get_viewport_rect().size.width + dead_size.width / 2, random_height))
	
		self.add_child(dead)

func _play():
	if not over : return
	over= false
	score = 0
	# Init player pos
	var p_scene = load("res://minigames/death_invaders/scenes/player.tscn")
	
	var player = p_scene.instance()
	player.set_pos(Vector2(
		self.get_viewport_rect().size.width / 10,
		self.get_viewport_rect().size.height / 2))
	self.add_child(player)
	
	# Generate some deads
	randomize(true)
	generate_deads()

func _gameover():
	over=true
	get_node("music_theme").stop()
	get_tree().set_pause(true)


func _ready():
	# Init var
	score = 0
	over=true
		
	# Allows game loop to turn
	set_process_input(true)
	set_fixed_process(true)



func _fixed_process(delta):
	
	if over && Input.is_action_pressed("ui_cancel"): _play()
	if over : return
	
	# Move the player
	var player = get_node("player")
	if Input.is_action_pressed("ui_up") : # move up
		player.move(Vector2(0, PLAYER_SPEED * -delta))
		# if out of screen then replace player
		if player.get_pos().y - player.get_item_rect().size.height/2 < 0 : 
			player.set_pos(Vector2(player.get_pos().x, player.get_item_rect().size.height/2)) 
			
	elif Input.is_action_pressed("ui_down") : # move down
		player.move(Vector2(0, PLAYER_SPEED * delta))
		# if out of screen then replace player
		var player_bottom = player.get_pos().y + player.get_item_rect().size.height/2
		if  player_bottom > self.get_viewport_rect().size.height : 
			var player_new_height = self.get_viewport_rect().size.height - player.get_item_rect().size.height/2
			player.set_pos(Vector2(player.get_pos().x, player_new_height )) 
	
	if Input.is_action_pressed("ui_select") :
		if player.getShootdownCount() ==  0.0 :
			player.shoot()
	
	# Move the deads
	var deads = get_tree().get_nodes_in_group("deads")
	for dead in deads :
		dead.move(Vector2(DEADS_SPEED * -delta, 0))
		var pos = dead.get_pos()
		
		if dead.is_colliding() && dead.get_collider().get_name() == "player":
			_gameover()
		elif pos.x + dead.get_item_rect().size.width/2 < 0 :
			dead.remove_from_group("deads")
			dead.queue_free()
			score -= 10
			if score < 0 :
				_gameover()
	
	
	# if player has shoot then move the bullet and check collisions
	var bullets = get_tree().get_nodes_in_group("bullets")
	for bullet in bullets :
		# move the bullet
		bullet.move(Vector2(BULLET_SPEED * delta, 0))
		var b_pos = bullet.get_pos()
		
		#check if bullet collides a dead or the and of screen
		if bullet.is_colliding() || b_pos.x >= self.get_viewport_rect().size.width :
			if bullet.is_colliding() : # if collides a dead, rekill the dead
				bullet.get_collider().remove_from_group("deads")
				bullet.get_collider().queue_free()
				score += 10
			bullet.remove_from_group("bullets")
			bullet.queue_free()
			
	# Generate some deads
	if randf() < SPAWN_RATE :
		generate_deads()

	get_node("player").decreaseShootdownCount(delta)
	
	
	
