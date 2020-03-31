extends KinematicBody2D

var speed = 250
var dir = Vector2()
var movement = Vector2()
var player
var state = "idle"
var conversation = {
	"question": load("res://Enemies/Spider_Boss/Sounds/Question.ogg"),
	"correct": load("res://Enemies/Spider_Boss/Sounds/CorrectAnswer.ogg"), 
	"wrong": load("res://Enemies/Spider_Boss/Sounds/WrongAnswer.ogg")
	}

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	

func _physics_process(delta):
	if player != null and state == "attack":
		rotation = global_position.angle_to_point( player.global_position )
		dir = global_position.direction_to( player.global_position )
		move_and_slide(dir*speed)
	
		if get_slide_count() > 0:
			var collision = get_slide_collision(0)
			if collision.collider.is_in_group("Player"):
				UI.restart_level()


func _on_Area_Vision_body_entered(body):
	if body.is_in_group("Player") and $AudioStreamPlayer2D.stream == null:
		$AudioStreamPlayer2D.stream = conversation["question"]
		$AudioStreamPlayer2D.stream.loop = false
		$AudioStreamPlayer2D.play()


func _on_AudioStreamPlayer2D_finished():
	if state == "idle":
		$Answer.show()
		state = "waiting_answer"


func _on_Button_pressed():
	$Answer.hide()
	if int($Answer/LineEdit.text) == 96:
		$AudioStreamPlayer2D.stream = conversation["correct"]
		$AudioStreamPlayer2D.stream.loop = false
		$AudioStreamPlayer2D.play(1.0)
		state = "no attack"
		
	else:
		$AudioStreamPlayer2D.stream = conversation["wrong"]
		$AudioStreamPlayer2D.stream.loop = false
		$AudioStreamPlayer2D.play(1.0)
		state = "attack"
	pass # Replace with function body.
