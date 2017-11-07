extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass


func _on_Body_body_enter( body ):
	body.increase_score()
	self.queue_free()
