extends Area2D 

func _on_Earth_Shard_body_entered(body):
	if body.is_in_group("Player"):
		body.build_wall += 1
		queue_free()
