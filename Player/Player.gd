extends KinematicBody2D

var gravity = 35

var speed = 350
var direction = Vector2()
var movement = Vector2()
var jump_strength = 900
var look_direction = 1
var floor_normal = Vector2.UP

var life = 3
var poisoned = false
var knocked = false
var coffeed = false
var riding = false

onready var sounds = $Player_Sounds

export var air_skill = 133

export var earth_skill = 22
var load_wall = load( "res://Colectables/Earth_Shard/Earth_Wall.tscn" )

export var water_skill = 30
var load_water_jet = load( "res://Colectables/Water_Shard/Water_Jet.tscn" )

export var fire_skill = 45
var load_fire_ball = load( "res://Colectables/Fire_Shard/Fire_Ball.tscn" )

export var coffee_beans = 43
export var coffee = 43

func _ready():
	Audio.change_music()
	

func _physics_process(delta):
	$"Player_UI/Interface".update_ui({ 
		"Air_Skill":air_skill,
		"Earth_Skill":earth_skill,
		"Fire_Skill":fire_skill,
		"Water_Skill":water_skill,
		"Coffee":coffee,
		"Coffee_Beans":coffee_beans,
		"Life":life })
	
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
			if is_on_floor():
				movement.y = -jump_strength
				sounds.play_audio("Jump")
			elif is_on_wall():
				movement.y = -jump_strength
				knock_back(Vector2(get_slide_collision(0).normal.x*700, -jump_strength), 0.2)
				sounds.play_audio("Jump")
			elif air_skill > 0:
				"""
				Se pressionar a tecla de pulo, nao estiver no chao e
				air_skill for maior do que zero, pule e subtraia de air_skill
				"""
				movement.y = -jump_strength
				air_skill -= 1
				sounds.play_audio("Jump")
		 
		""" Caso a condicao do Player seja 'Poisoned' os controles serão invertidos"""
		if poisoned == true:
			movement.x *= -1
			look_direction *= -1
		
	
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
			add_child(water_jet)
			water_jet.get_node("AnimatedSprite").rotation *= look_direction
			water_jet.global_position.x = global_position.x + ( look_direction * 64)
			water_jet.global_position.y = global_position.y
	elif event.is_action_pressed("fire_skill"):
		if fire_skill > 0:
			fire_skill -= 1
			var fire_ball = load_fire_ball.instance()
			get_parent().add_child(fire_ball)
			fire_ball.direction.x = look_direction
			fire_ball.global_position.x = global_position.x + ( look_direction * 84 )
			fire_ball.global_position.y = global_position.y
			sounds.play_audio("FireBall")
	elif event.is_action_pressed("coffe_skill"):
		if coffee > 0:
			if coffeed == false:
				sounds.play_audio("DrinkCoffee")
				life += 0.5
				coffee -= 1
				speed *= 2
				coffeed = true
				yield(get_tree().create_timer(5),"timeout")
				speed /= 2
				coffeed = false
	
func set_animation():
	if riding == true:
		$AnimatedSprite.play("ride")
		if direction.x > 0:
			$AnimatedSprite.flip_h = false
		elif direction.x < 0:
			$AnimatedSprite.flip_h = true
	elif knocked == false:
		if direction.x > 0:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play( "walk" )
		elif direction.x < 0:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play( "walk" )
		else:
			$AnimatedSprite.play( "idle" )
		
		if !is_on_floor():
			$AnimatedSprite.play( "jump" )

func poison():
	poisoned = true
	$AnimationPlayer.play("poison")
	$PoisonTimer.start(15.0)
	

func _on_PoisonTimer_timeout():
	poisoned = false
	$AnimationPlayer.seek(0.0, true)
	$AnimationPlayer.stop()

func knock_back(knock_impulse, knock_duration):
	movement = knock_impulse
	knocked = true
	yield( get_tree().create_timer(knock_duration), "timeout")
	knocked = false

func apply_damage(amount):
	if knocked != true:
		sounds.play_audio("Damage")
		life -= amount
		if life <= 0:
			get_tree().reload_current_scene()

func ride(activate):
	if activate == true:
		collision_layer = 2
		collision_mask = 2
		set_physics_process(false)
		set_process_input(false)
		riding = true
		$AnimatedSprite.play("ride")
	else:
		set_physics_process(true)
		set_process_input(true)
		riding = false
		knock_back(Vector2(0, -1000), 0.5)
		$Timer_Collisions.start(0.1)

func _on_Timer_Collisions_timeout():
		collision_layer = 1
		collision_mask = 1
