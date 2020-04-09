extends Area2D

export var life = 5

signal destroyed


func _process(delta: float) -> void:
	if modulate.r > 0:
		modulate.g = min( 1 , modulate.g + (delta * 5) )
		modulate.b = min( 1 , modulate.b + (delta * 5) )

func _on_PoorHouse1_area_entered(area: Area2D) -> void:
	if area.is_in_group("spell"):
		area.queue_free()
		life -= 1
		modulate = Color(1,0,0)
		if life <= 0 :
			$CollisionShape2D.queue_free()
			$Sprites.hide()
			$Destroyed.show()
			emit_signal("destroyed")
		
