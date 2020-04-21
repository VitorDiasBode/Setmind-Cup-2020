tool
extends Area2D

export  (float) var rotate_motion = 0

export (Texture) var texture setget set_texture

export (Vector2) var motion

export (float) var speed

export (float , EXP , 0 , 1000) var move_range = 20 

onready var initial_position = position

var steps = Vector2()

export (Vector2) var size setget set_size

export (Vector2) var offest setget set_offset

func _physics_process(delta: float) -> void:
	if not Engine.editor_hint:
		$Sprite.rotate(rotate_motion * delta)
		translate(motion * delta * speed )
		steps.x = abs(position.x - initial_position.x)
		steps.y = abs(position.y - initial_position.y)
		
		if steps.x > move_range or steps.x <= 0:
			motion.x = motion.x * -1
			
		if steps.y > move_range or steps.y <= 0:
			motion.y = motion.y * -1

func set_texture(tex):
	texture = tex
	$Sprite.texture = tex

func set_offset(off:Vector2):
	offest = off
	set_size(size)

func set_size(area:Vector2):
	size = area
	var ix = 0
	var iy = 0

	if $Sprite.texture != null:
		ix = -( $Sprite.texture.get_height() / 2 ) + offest.x
		iy = -( $Sprite.texture.get_width() / 2 ) + offest.y
		
	var array = [ 
			Vector2(ix,iy),
			Vector2(area.x,iy),
			Vector2(area.x,area.y),
			Vector2(ix,area.y)
		 ]
	
	if not is_inside_tree(): yield(self, 'ready')
	
	$CollisionPolygon2D.polygon = PoolVector2Array(array)

