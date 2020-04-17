tool
extends KinematicBody2D

const GRAVITY = -35

export (float) var speed = 500.0
export var movement_distance = 400.0

var direction = Vector2(1,0)
var movement = Vector2()
var jump_strength = 900.0
var distance_traveled = 0.0
onready var start_postion = global_position.x

var rider
var state = "patrol"
var life = 3

func _physics_process(delta):
	if state == "patrol":
		patrol_movement()
		
	elif state == "rided":
		rided_movement()
		
	set_animation()

func _input(event):
	if event.is_action_pressed("ui_up"):
		if state == "rided":
			rider.ride(false)
			rider.knock_back(Vector2(0,-1000), 0.5)
			state = "patrol"
			direction.x = 1
			start_postion = global_position.x - 1

func rided_movement():
	rider.global_position = $Rider_Position.global_position
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
	else:
		direction.x = 0
	
	rider.direction.x = direction.x
	
	movement.x = direction.x*speed
	if !is_on_floor():
		movement.y -= GRAVITY
	movement = move_and_slide(movement, Vector2.UP)

func patrol_movement():
	distance_traveled = abs(start_postion - global_position.x )
	if distance_traveled >= movement_distance or is_on_wall():
			direction *= -1
			distance_traveled = 0
		
	movement.x = direction.x*speed
	if !is_on_floor():
		movement.y -= GRAVITY
	move_and_slide(movement, Vector2.UP)


func set_animation():
	if rider !=null:
		rider.set_animation()

func apply_damage(amount):
	life -= amount 
	if life <= 0:
		queue_free()

func _on_Area_Ride_body_entered(body):
	if state == "patrol":
		if body.is_in_group("Player"):
			randomize()
			if randf() > 0.20:
				rider = body
				rider.ride(true)
				state = "rided"
				
			else:
				body.knock_back(Vector2(0,-1000), 0.5)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.sounds.play_audio("Damage")
		var knock_direction = (body.global_position - global_position).normalized()
		body.apply_damage(1)
		body.knock_back(Vector2(knock_direction.x*600, knock_direction.y*900), 0.5)
	pass # Replace with function body.
