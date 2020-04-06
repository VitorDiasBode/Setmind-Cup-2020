extends Area2D

export (String, MULTILINE)var speech = ""

func _on_Master_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		owner.get_node("UI").show_text(speech)
	
func _on_Master_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		owner.get_node("UI").hide_text()
