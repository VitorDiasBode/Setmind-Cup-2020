extends Area2D 

func _on_Air_Shard_body_entered(body):
	print("Entrou")
	if body.is_in_group("Player"):
		body.air_skill += 1
		while $Light2D.energy > 0.1:
			print($Light2D.energy)
			break
#			$CollisionPolygon2D/Light2D.energy = lerp($CollisionPolygon2D/Light2D.energy, $CollisionPolygon2D/Light2D.energy-get_physics_process_delta_time(), 0.3)
			
