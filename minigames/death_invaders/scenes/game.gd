extends Node2D

func _input(event):
	if event.type == InputEvent.KEY :
		if event.scancode == KEY_SPACE :
			if !has_node("bullet") :
				get_node("player").shoot()


func _ready():
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
	get_tree().call_group(0, "deads", "move", Vector2(100 * -delta, 0))
	
	
	# if player has shoot then move the bullet and check collisions
	if has_node("bullet") :
		# move the bullet
		var bullet = get_node("bullet")
		bullet.move(Vector2(200 * delta, 0))
		var b_pos = bullet.get_pos()
		
		#check if bullet collides a dead or the and of screen
		if bullet.is_colliding() || b_pos.x >= self.get_viewport_rect().size.width :
			if bullet.is_colliding() : # if collides a dead, rekill the dead
				bullet.get_collider().queue_free()
			bullet.queue_free()
			
	
	
	
