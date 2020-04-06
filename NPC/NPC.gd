extends Area2D

export var speech = ""

func _on_NPC_body_entered(body):
	if body.is_in_group("Player"):
		UI.show_text(speech)


func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		UI.hide_text()

