tool
extends KinematicBody2D

enum directions {LEFT = -1 , RIGHT = 1}
export (directions) var initial_direction = 1

onready var dir = Vector2(initial_direction , 0)

var move = Vector2()

export (float) var speed = 200.0 

var gravity = 9.8

export (float , EXP , 0 , 1000 ) var walk_range
onready var initial_positions_x = global_position.x
var steps = 0

var splatter = load("res://Enemies/Rat/RatSplatter.tscn")

func _ready():
	if not Engine.editor_hint:
		$WalkRange.hide()

func _physics_process(delta):
	
	if Engine.editor_hint:
		$WalkRange/Right.rect_size.x = walk_range
		$WalkRange/Left.rect_size.x = walk_range
	else:
		if not is_on_floor():
			move.y += gravity
		else:
			move.y = 0
		
		if is_on_wall():
			dir.x = dir.x * -1
		
		$AnimatedSprite.flip_h = true if dir.x == -1 else false
		
		move.x = dir.x * speed
		
		move = move_and_slide( move , Vector2.UP )
		
		steps = abs(global_position.x - initial_positions_x)
		if steps > walk_range or steps <= 0:
			dir.x = dir.x * -1

func apply_damage(damage):
	var new_splatter = splatter.instance()
	get_parent().add_child(new_splatter)
	new_splatter.global_position = global_position
	queue_free()
