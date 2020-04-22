extends Position2D

func _physics_process(delta):
	if $R1_RayCast2D.is_colliding():
		var obj = $R1_RayCast2D.get_collider()
		if obj.is_in_group("FallingWall"):
			obj.player_step_over()
	
	elif $R2_RayCast2D.is_colliding():
		var obj = $R2_RayCast2D.get_collider()
		if obj.is_in_group("FallingWall"):
			obj.player_step_over()
