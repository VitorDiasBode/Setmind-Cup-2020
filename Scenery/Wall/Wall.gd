tool
extends StaticBody2D

export (Texture) var texture setget set_texture

export (Vector2) var size setget set_size


func set_texture(tex):
	texture = tex
	$Polygon2D.texture = tex

func set_size(area:Vector2):
	size = area
	var array = [ 
			Vector2(0,0),
			Vector2(area.x,0),
			Vector2(area.x,area.y),
			Vector2(0,area.y)
		 ]
	
	if not is_inside_tree(): yield(self, 'ready')
	
	$CollisionPolygon2D.polygon = PoolVector2Array(array)
	$Polygon2D.polygon = PoolVector2Array(array)
