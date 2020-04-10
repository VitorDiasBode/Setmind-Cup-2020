tool
extends KinematicBody2D

enum directions {LEFT = -1 , RIGHT = 1}
export (directions) var initial_direction = 1
onready var direction = Vector2(initial_direction , 0)
export (float , EXP , 0 , 1000 ) var walk_range
onready var initial_positions_x = global_position.x

const gravity = 35
export (float) var speed = 150.0 
var movement = Vector2()
var jump_strength = 900

var steps = 0

var player
var state = "patrol"
var life = 1
var coffee_load = load( "res://Colectables/Coffee_Beans/Coffee_Beans.tscn" )


func _ready():
	if not Engine.editor_hint:
		$WalkRange.hide()

func _physics_process(delta):
	
	if Engine.editor_hint:
		$WalkRange/Right.rect_size.x = walk_range
		$WalkRange/Left.rect_size.x = walk_range
	else:
		if $RayCast_Vision.enabled == true:
			var collider = $RayCast_Vision.get_collider()
		
			if collider != null:
				if collider.is_in_group("Player"):
					player = collider
					state = "attack"
					$RayCast_Vision.enabled = false
					speed = 200.0
		else:
			if get_slide_collision(0) != null:
				var collider = get_slide_collision(0).collider
				if collider.is_in_group("Player"):
					var knock_direction = (collider.global_position - global_position).normalized()
					collider.apply_damage(1)
					collider.knock_back(Vector2(knock_direction.x*600, knock_direction.y*900), 0.5)
					
	
	
		if not is_on_floor():
			movement.y += gravity
		else:
			movement.y = 0
		
		if state == "patrol":
			steps = abs(global_position.x - initial_positions_x)
			if steps > walk_range or steps <= 0 or is_on_wall():
				direction.x *= -1
				$RayCast_Vision.cast_to.x *= -1
		else:
			direction = ( player.global_position - global_position ).normalized()
		movement.x = direction.x * speed
		
		set_animation()
		movement = move_and_slide( movement , Vector2.UP )
		
	


func set_animation():
	$AnimatedSprite.flip_h = direction.x < 0

func apply_damage(amount):
	life -= amount 
	if life <= 0:
		randomize()
		if randf() > 0.75:
			var coffee = coffee_load.instance()
			owner.add_child(coffee)
			coffee.global_position = global_position
		queue_free()
	pass
