extends Area2D

func _on_Coffee_Beans_body_entered(body):
	if body.is_in_group("Player"):
		body.coffee_beans += 1
		queue_free()
