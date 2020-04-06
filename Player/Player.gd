extends KinematicBody2D

var gravity = 35

var speed = 350
var direction = Vector2()
var movement = Vector2()
var jump_strength = 900
var look_direction = 1
var floor_normal = Vector2.UP

var poisoned = false
var knocked = false

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
#	print(condition)
	if knocked == false:
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
		if Input.is_action_just_pressed("ui_up"):
			if is_on_floor() or is_on_wall():
				movement.y = -jump_strength
			elif air_skill > 0:
				"""
				Se pressionar a tecla de pulo, nao estiver no chao e
				air_skill for maior do que zero, pule e subtraia de air_skill
				"""
				movement.y = -jump_strength
				air_skill -= 1
		 
		""" Caso a condicao do Player seja 'Poisoned' os controles serão invertidos"""
		if poisoned == true:
			movement.x *= -1
		
	
	"""
	Chama a função move_and_slide e passa como parametro qual o movimento
	que deve ser seguido e de que lado está o chão.
	"""
	movement.y += gravity
	movement = move_and_slide(movement, Vector2.UP)
	set_animation()

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
	
func set_animation():
	if knocked == false:
		if movement.x > 0:
			$AnimatedSprite.play( "walk" )
			$AnimatedSprite.flip_h = false
		elif movement.x < 0:
			$AnimatedSprite.play( "walk" )
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.play( "idle" )

func poison():
	poisoned = true
	$AnimationPlayer.play("poison")
	$PoisonTimer.stop()
	$PoisonTimer.start(15.0)
	

func _on_PoisonTimer_timeout():
	poisoned = false
	$AnimationPlayer.seek(0.0, true)
	$AnimationPlayer.stop()

func knock_back(knock_origin, knock_strength, knock_duration):
	movement = (global_position - knock_origin).normalized() * knock_strength.x
	movement.y = knock_strength.y
	knocked = true
	yield( get_tree().create_timer(knock_duration), "timeout")
	knocked = false
	


