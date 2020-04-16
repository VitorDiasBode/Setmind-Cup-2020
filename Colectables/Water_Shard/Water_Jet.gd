extends Area2D

var push = 300

func _on_Water_Jet_body_entered(body):
	if body.is_in_group("Push"):
		body.movement.x = push

func _on_Water_Jet_body_exited(body):
	if body.is_in_group("Push"):
		body.movement.x = 0

func _physics_process(delta):
	$AnimatedSprite.modulate.a -= delta*0.5
