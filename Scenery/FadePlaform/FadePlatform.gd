tool
extends StaticBody2D

export (Texture) var texture setget set_texture

enum OPTIONS { OUT = 0 , IN = 1}
export (OPTIONS) var status = OPTIONS.IN

export (float) var time_out
export (float) var time_in
var time = 0

export (Vector2) var size setget set_size

func _physics_process(delta: float) -> void:
	if not Engine.editor_hint:
		if status == OPTIONS.IN:
			time += delta
			if time > time_in:
				time = 0
				status = OPTIONS.OUT
				$CollisionPolygon2D.disabled = true
				$AnimationPlayer.play("Fade_Out")
				
		elif status == OPTIONS.OUT:
			time += delta
			if time > time_out:
				time = 0
				status = OPTIONS.IN
				$CollisionPolygon2D.disabled = false
				$AnimationPlayer.play("Fade_In")

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
