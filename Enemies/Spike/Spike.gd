extends TextureRect


func _ready() -> void:
	var x = 0
	var y = 0
	var w = rect_size.x
	var h = rect_size.y
	
	var array = [
		Vector2(x,y),
		Vector2(x+w,y),
		Vector2(x+w,y+h),
		Vector2(x,y+h) 
	]
	
	var poly = PoolVector2Array( array)
	
	$Area2D/CollisionPolygon2D.polygon = poly

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		UI.restart_level()

