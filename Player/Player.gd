extends KinematicBody2D

const GRAVITY = 35

var speed = 350
var direction = Vector2()
var movement = Vector2()
var jump_strength = 900
var look_direction = 1


var extra_jump = 1
var build_wall = 1
var load_wall = load( "res://Colectables/Earth_Shard/Earth_Wall.tscn" )

var push_objects_skill = 0
var burn_skill = 0

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
		if Input.is_action_just_pressed("ui_up") and extra_jump > 0:
			movement.y = -jump_strength
			extra_jump -= 1
		else:
			movement.y += GRAVITY
	
	"""
	Chama a função move_and_slide e passa como parametro qual o movimento
	que deve ser seguido e de que lado está o chão.
	"""
	movement = move_and_slide(movement, Vector2.UP)

func _input(event):
	if event.is_action_pressed("earth_skill"):
		if build_wall > 0:
			build_wall -= 1
			var wall = load_wall.instance()
			wall.global_position.x = global_position.x + ( look_direction * 84 )
			wall.global_position.y = global_position.y
			get_parent().add_child(wall)
			
			
			
			
