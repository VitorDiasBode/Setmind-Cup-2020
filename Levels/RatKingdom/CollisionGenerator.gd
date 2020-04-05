extends StaticBody2D


func _ready() -> void:
	var polys = get_children()
	for p in polys:
		if p is Polygon2D:
			var shape = CollisionPolygon2D.new()
			add_child(shape)
			shape.polygon = p.polygon
			
