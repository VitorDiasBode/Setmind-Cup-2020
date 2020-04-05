extends Path2D

export var move_speed = 100

func _ready():
	$PathFollow2D/AnimatedSprite.speed_scale *= move_speed*0.01*get_physics_process_delta_time()

func _physics_process(delta):
	$PathFollow2D.offset += move_speed*delta



func _on_AreaAttack_body_entered(body):
	if body.is_in_group("Player"):
		$PathFollow2D/AnimatedSprite.play("Attack")
		UI.restart_level()
	pass # Replace with function body.