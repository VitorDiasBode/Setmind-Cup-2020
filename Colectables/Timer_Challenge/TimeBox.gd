extends StaticBody2D


func open():
	$Closed.hide()
	$CollisionShape2D.set_deferred("disabled", true)
	
func close():
	$Closed.show()
	$CollisionShape2D.set_deferred("disabled", false)
