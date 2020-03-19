extends KinematicBody2D

const GRAVITY = 35

var speed = 350
var direction = Vector2()
var movement = Vector2()
var jump_strength = 900
var look_direction = 1


var air_skill = 1

var earth_skill = 0
var load_wall = load( "res://Colectables/Earth_Shard/Earth_Wall.tscn" )

var water_skill = 0
var load_water_jet = load( "res://Colectables/Water_Shard/Water_Jet.tscn" )

var fire_skill = 45
var load_fire_ball = load( "res://Colectables/Fire_Shard/Fire_Ball.tscn" )

func _ready():
	Audio.change_music()

func _physics_process(delta):
	"""
	Defini para qual direção o jogador deve se mover
	"""
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		look_direction = -1
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
		look_direction = 1
	else:
		direction.x = 0
	
	"""
	Constroi uma projeção de movimento horizontal, que usa a direção 
	de movimento e a velocidade, e vertical que usa a força do pulo e
	a força da gravidade.
	"""
	movement.x = speed*direction.x
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			movement.y = -jump_strength
		else:
			movement.y = 0
	else:
		""" 
		Se não estiver no chão, pressionar a tecla para cima e ainda tiver
		pulos extra disponíveis, perde um pulo extra e recebe o impulso
		"""
		if Input.is_action_just_pressed("ui_up") and air_skill > 0:
			movement.y = -jump_strength
			air_skill -= 1
		else:
			movement.y += GRAVITY
	
	"""
	Chama a função move_and_slide e passa como parametro qual o movimento
	que deve ser seguido e de que lado está o chão.
	"""
	movement = move_and_slide(movement, Vector2.UP)

func _input(event):
	if event.is_action_pressed("earth_skill"):
		if earth_skill > 0:
			earth_skill -= 1
			var wall = load_wall.instance()
			get_parent().add_child(wall)
			wall.global_position.x = global_position.x + ( look_direction * 84 )
			wall.global_position.y = global_position.y
			
	elif event.is_action_pressed("water_skill"):
		if water_skill > 0:
			water_skill -= 1
			var water_jet = load_water_jet.instance()
			get_parent().add_child(water_jet)
			water_jet.growth_scale = water_jet.growth_scale * look_direction
			water_jet.global_position.x = global_position.x + ( look_direction * 84 )
			water_jet.global_position.y = global_position.y
	elif event.is_action_pressed("fire_skill"):
		if fire_skill > 0:
			fire_skill -= 1
			var fire_ball = load_fire_ball.instance()
			get_parent().add_child(fire_ball)
			fire_ball.direction.x = look_direction
			fire_ball.global_position.x = global_position.x + ( look_direction * 84 )
			fire_ball.global_position.y = global_position.y
			
			
			
			
