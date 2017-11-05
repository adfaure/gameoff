extends Node2D

func _input(event):
	if event.type == InputEvent.KEY :
		if event.scancode == KEY_SPACE :
			if get_node("player").getShootdownCount() ==  0.0 :
				get_node("player").shoot()

func generate_deads():
	var d_scene = load("res://minigames/death_invaders/scenes/dead.tscn")
	
	var dead = d_scene.instance()
	
	dead.set_pos(Vector2(
		self.get_viewport_rect().size.width + dead.get_item_rect().size.width / 2,
		rand_range(dead.get_item_rect().size.height / 2, 
			self.get_viewport_rect().size.height - dead.get_item_rect().size.height / 2)))
	
	self.add_child(dead)

func _ready():
	
	# Init player pos
	var p_scene = load("res://minigames/death_invaders/scenes/player.tscn")
	
	var player = p_scene.instance()
	player.set_pos(Vector2(
		self.get_viewport_rect().size.width / 4,
		self.get_viewport_rect().size.height / 2))
	self.add_child(player)
	
	
	# Generate some deads
	randomize(true)
	generate_deads()
	
	# Allows game loop to turn
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	
	# Move the player
	var player = get_node("player")
	if Input.is_key_pressed(KEY_UP) : # move up
		player.move(Vector2(0, 100 * -delta))
		# if out of screen then replace player
		if player.get_pos().y - player.get_item_rect().size.height/2 < 0 : 
			player.set_pos(Vector2(player.get_pos().x, player.get_item_rect().size.height/2)) 
	
	elif Input.is_key_pressed(KEY_DOWN) : # move down
		player.move(Vector2(0, 100 * delta))
		# if out of screen then replace player
		if player.get_pos().y + player.get_item_rect().size.height/2 > self.get_viewport_rect().size.height : 
			player.set_pos(Vector2(player.get_pos().x, self.get_viewport_rect().size.height - player.get_item_rect().size.height/2)) 
	
	
	
	# Move the deads
	var deads = get_tree().get_nodes_in_group("deads")
	for dead in deads :
		dead.move(Vector2(50 * -delta, 0))
		var pos = dead.get_pos()
		
		if pos.x + dead.get_item_rect().size.width/2 < 0 :
			dead.remove_from_group("deads")
			dead.queue_free()
	
	
	# if player has shoot then move the bullet and check collisions
	var bullets = get_tree().get_nodes_in_group("bullets")
	for bullet in bullets :
		# move the bullet
		bullet.move(Vector2(200 * delta, 0))
		var b_pos = bullet.get_pos()
		
		#check if bullet collides a dead or the and of screen
		if bullet.is_colliding() || b_pos.x >= self.get_viewport_rect().size.width :
			if bullet.is_colliding() : # if collides a dead, rekill the dead
				bullet.get_collider().remove_from_group("deads")
				bullet.get_collider().queue_free()
			bullet.remove_from_group("bullets")
			bullet.queue_free()
			
	
	# Generate some deads
	if randf() < 0.015 :
		generate_deads()
	
	get_node("player").decreaseShootdownCount(delta)
	
	
	
