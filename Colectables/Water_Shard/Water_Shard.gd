extends Area2D 

func _on_Water_Shard_body_entered(body):
	if body.is_in_group("Player"):
		body.water_skill += 1
		queue_free()
