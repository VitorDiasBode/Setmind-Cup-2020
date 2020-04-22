extends Area2D


var active = false
export (NodePath) var reward
export (float) var time = 10

onready var box = $Node/TimeBox
#var box_open = false

func _ready():
	if not reward == null:
		reward = get_node(reward)
		reward.hide()

		box.global_position = reward.global_position
		reward.connect("tree_exited",self,"destroy")
	
func _physics_process(delta: float) -> void:
	if active == true:
		$CanvasLayer/TimerLabel.text = str( round( $Timer.time_left*10 ) / 10 )
	

func _on_TimerChallenge_body_entered(body):
	if body.is_in_group("Player"):
		active = true
		$CollisionShape2D.set_deferred("disabled", true)
		hide()
		$CanvasLayer/TimerLabel.show()
		$Timer.start(time)
		box.open()
		if not reward == null:
			reward.show()

func _on_Timer_timeout():
	active = false
	$CollisionShape2D.set_deferred("disabled", false)
	show()
	$CanvasLayer/TimerLabel.hide()
	box.close()
	if not reward == null:
		reward.hide()

		
func destroy():
	queue_free()

	
