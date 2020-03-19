extends Area2D 

func _on_Fire_Shard_body_entered(body):
	if body.is_in_group("Player"):
		body.fire_skill += 1
		queue_free()
