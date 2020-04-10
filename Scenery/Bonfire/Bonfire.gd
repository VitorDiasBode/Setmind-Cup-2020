extends Area2D

var player

func _on_Bonfire_body_entered(body):
	if body.is_in_group("Player"):
		$Dialogue.show()
		player = body
	


func _on_Bonfire_body_exited(body):
	if body.is_in_group("Player"):
		$Dialogue.hide()


func _on_Yes_Button_pressed():
	player.coffee += player.coffee_beans
	player.coffee_beans = 0
	$Dialogue.hide()
