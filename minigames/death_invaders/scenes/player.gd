extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func shoot():
	# Load bullet scene for instancing
	var scene = load("res://minigames/death_invaders/scenes/bullet.tscn")
	
	# Create an instance of a bullet
	var bullet = scene.instance()
	
	# Get player's position
	var p_pos = self.get_pos()
	
	bullet.set_scale(Vector2(0.2, 0.2))
	bullet.set_pos(Vector2(p_pos.x + 27, p_pos.y))
	
	self.get_parent().add_child(bullet)
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
