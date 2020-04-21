extends Area2D


var active = false
export (NodePath) var reward
export (float) var time = 10

var box = load("res://Colectables/Timer_Challenge/TimeBox.tscn")

func _ready():
	if not reward == null:
		reward = get_node(reward)
		reward.hide()

		var new_box = box.instance()
		get_tree().root.call_deferred("add_child",new_box)
		new_box.global_position = reward.global_position
		box = new_box
		
		reward.connect("tree_exited",self,"destroy")
	
func _physics_process(delta: float) -> void:
	if active == true:
		box.get_node("CollisionShape2D").disabled = true
		$CanvasLayer/TimerLabel.text = str( round( $Timer.time_left*10 ) / 10 )
	else:
		box.get_node("CollisionShape2D").disabled = false

func _on_TimerChallenge_body_entered(body):
	if body.is_in_group("Player"):
		active = true
		$CollisionShape2D.set_deferred("disabled", true)
		hide()
		$CanvasLayer/TimerLabel.show()
		$Timer.start(time)
		if not reward == null:
			reward.show()
		
		if box.has_method("open"):
			box.open()

func _on_Timer_timeout():
	active = false
	$CollisionShape2D.set_deferred("disabled", false)
	show()
	$CanvasLayer/TimerLabel.hide()
	if not reward == null:
		reward.hide()
	
	if box.has_method("close"):
		box.close()
		
func destroy():
	queue_free()

	