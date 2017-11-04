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
	
	# if player has shoot
	if has_node("bullet") :
		# move the bullet
		var bullet = get_node("bullet")
		bullet.move(Vector2(100 * delta, 0))
		var b_pos = bullet.get_pos()
		
		#check if bullet collides a dead or the and of screen
		if bullet.is_colliding() || b_pos.x >= self.get_viewport_rect().size.width :
			if bullet.is_colliding() : # if collides a dead, rekill the dead
				bullet.get_collider().queue_free()
			bullet.queue_free()
	
