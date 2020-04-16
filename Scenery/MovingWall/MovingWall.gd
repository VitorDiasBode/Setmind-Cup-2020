tool
extends KinematicBody2D


export (Texture) var texture setget set_texture

export (Vector2) var motion

export (float) var speed

export (float , EXP , 0 , 1000) var move_range = 20 

export (Vector2) var size setget set_size

onready var initial_position = position

var steps = Vector2()


func _physics_process(delta: float) -> void:
	if not Engine.editor_hint:
		translate(motion * delta * speed )
		steps.x = abs(position.x - initial_position.x)
		steps.y = abs(position.y - initial_position.y)
		
		if steps.x > move_range or steps.x <= 0:
			motion.x = motion.x * -1
			
		if steps.y > move_range or steps.y <= 0:
			motion.y = motion.y * -1


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

