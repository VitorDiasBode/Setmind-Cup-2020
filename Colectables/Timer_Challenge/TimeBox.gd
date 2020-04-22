extends StaticBody2D

var box_open = false

func _process(delta: float) -> void:
	$CollisionShape2D.disabled = box_open

func open():
	box_open = true
	$Closed.hide()
	$CollisionShape2D.set_deferred("disabled", true)
	
func close():
	box_open = false
	$Closed.show()
	$CollisionShape2D.set_deferred("disabled", false)
