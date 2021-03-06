tool
extends KinematicBody2D


onready var initial_pos = global_position

export (Texture) var texture setget set_texture

export (float) var fall_speed = 50

export (Vector2) var size setget set_size

export (float) var time_trigger = 5 # Precisa

var falling = false # Precisa

var triggered = false # Precisa

func _physics_process(delta: float) -> void:
	if not Engine.editor_hint:
		if falling == true:
			translate(Vector2.DOWN * fall_speed * delta )

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


func player_step_over(): # Passo 1
	if triggered == false:
		triggered = true
		$Timer.start(time_trigger)
		$AnimationPlayer.play("Shake")

func _on_Timer_timeout(): # Passo 2
	if falling == false:
		$AnimationPlayer.play("Fade_Out") #Hide no lugar
		falling = true
		$Timer.start(5)
		$CollisionPolygon2D.set_deferred("disabled",true)
	else:
		falling = false
		triggered = false
		global_position = initial_pos
		$AnimationPlayer.play("Fade_In") #Show no lugar
		$CollisionPolygon2D.set_deferred("disabled",false)

func reset():
	$Timer.stop()
	$AnimationPlayer.play("Fade_In")
	falling = false
	triggered = false
	global_position = initial_pos
	$CollisionPolygon2D.set_deferred("disabled",false)
