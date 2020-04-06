extends Area2D

var direction = Vector2()
var speed = 550

func _physics_process(delta):
	global_position.x += direction.x*speed*delta

func _on_Spell_area_entered(area):
	if area.is_in_group("Vine"):
		area.owner.queue_free()
		queue_free()

func _on_Spell_body_entered(body):
	if body.is_in_group("Enemy"):
		body.knock_back(global_position, Vector2(500, 500), 0.8)
	queue_free()
	
