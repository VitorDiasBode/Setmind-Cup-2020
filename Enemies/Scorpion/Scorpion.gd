tool
extends KinematicBody2D

enum directions {LEFT = -1 , RIGHT = 1}
export (directions) var initial_direction = 1
onready var direction = Vector2(initial_direction , 0)
export (float , EXP , 0 , 1000 ) var walk_range
onready var initial_positions_x = global_position.x
var steps = 0

const gravity = 35
export (float) var speed = 500.0
var movement = Vector2()
var jump_strength = 900


var rider
var state = "patrol"
var life = 3

func _ready():
	if not Engine.editor_hint:
		$WalkRange.hide()

func _physics_process(delta):
	
	if Engine.editor_hint:
		$WalkRange/Right.rect_size.x = walk_range
		$WalkRange/Left.rect_size.x = walk_range
	else:
		if state == "rided":
			rider.global_position = $Rider_Position.global_position
			if Input.is_action_pressed("ui_left"):
				direction.x = -1
				rider.direction.x = -1
			elif Input.is_action_pressed("ui_right"):
				direction.x = 1
				rider.direction.x = 1
			else:
				direction.x = 0
			
			movement.x = speed*direction.x
			if is_on_floor():
				if Input.is_action_just_pressed("ui_up"):
					state = "patrol"
					rider.ride(false)
					rider.knock_back(Vector2(0, -1200), 0.5)
					initial_positions_x = global_position.x
					direction.x = 1 
			else:
				movement.y += gravity
		else:
			if get_slide_count() > 0:
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
			
			movement.x = direction.x * speed
		
		movement = move_and_slide( movement , Vector2.UP )
		
		set_animation()


func set_animation():
	if rider !=null:
		rider.set_animation()
	pass

func apply_damage(amount):
	life -= amount 
	if life <= 0:
		queue_free()

func _on_Area_Ride_body_entered(body):
	if body.is_in_group("Player"):
		randomize()
		if randf() > 0.20:
			rider = body
			state = "rided"
			rider.ride(true)
		else:
			body.knock_back(Vector2(0,-1000), 0.5)
	pass # Replace with function body.
