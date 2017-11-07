extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	draw_line(Vector2(0, 0), Vector2(50, 50), Color(255, 0, 0), 5)
	update()
