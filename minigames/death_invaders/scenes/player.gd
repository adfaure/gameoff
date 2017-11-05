extends KinematicBody2D

const SHOOTDOWN = 50.0
var shootdown_count = 0.0

func shoot():
	# Load bullet scene for instancing
	var b_scene = load("res://minigames/death_invaders/scenes/bullet.tscn")
	
	# Create an instance of a bullet
	var bullet = b_scene.instance()
	
	# Get player's position
	var p_pos = self.get_pos()
	
	bullet.set_scale(Vector2(0.2, 0.2))
	bullet.set_pos(Vector2(p_pos.x + 27, p_pos.y))
	
	self.get_parent().add_child(bullet)
	
	shootdown_count = SHOOTDOWN

func decreaseShootdownCount(delta):
	if shootdown_count > 0.0 :
		shootdown_count -= 100.0 * delta
	
	if shootdown_count < 0.0 :
		shootdown_count = 0.0

func getShootdownCount():
	return shootdown_count

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
