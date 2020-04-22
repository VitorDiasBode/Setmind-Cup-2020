extends Area2D


var active = false
export (NodePath) var reward
export (float) var time = 10

onready var box = $Node/TimeBox #Não Precisa
#var box_open = false

func _ready(): # Precisa
	if not reward == null:
		reward = get_node(reward)
		reward.hide()
	
		#Aqui dar um Get node no Sprite do Bau
		# get_node("Box").global_position = reward.global_position
		box.global_position = reward.global_position
		reward.connect("tree_exited",self,"queue_free")
	
func _physics_process(delta: float) -> void: # Precisa
	if active == true:
		$CanvasLayer/TimerLabel.text = str( round( $Timer.time_left*10 ) / 10 )

func _on_TimerChallenge_body_entered(body): # Precisa
	if body.is_in_group("Player"):
		active = true
		$CollisionShape2D.set_deferred("disabled", true)
		hide()
		$CanvasLayer/TimerLabel.show()
		$Timer.start(time)
		box.open() #Não Precisa
		if not reward == null: #Não Precisa
			reward.show()

func _on_Timer_timeout(): #Precisa
	active = false
	$CollisionShape2D.set_deferred("disabled", false)
	show()
	$CanvasLayer/TimerLabel.hide()
	box.close() #Não Precisa
	if not reward == null:  #Não Precisa
		reward.hide()

