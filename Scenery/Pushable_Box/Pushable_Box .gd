extends KinematicBody2D

const GRAVITY = 35
var movement = Vector2()

func _physics_process(delta):
	if !is_on_floor():
		movement.y += GRAVITY
	else:
		movement.y = 0
	
	movement = move_and_slide(movement, Vector2.UP)
