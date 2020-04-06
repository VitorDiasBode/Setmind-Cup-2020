extends Area2D 

func _on_Air_Shard_body_entered(body):
	if body.is_in_group("Player"):
		body.air_skill += 1
		queue_free()
