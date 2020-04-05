extends Area2D

var peacefull = true
	
export (String, MULTILINE)var speech = ""


func rat_killed():
	peacefull = false
	speech = "Oque você fez! Você matou indivíduos do meu Cantão, eles não fizeram nada para você… Porque Humano? Porque?"

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("water_skill"):
		print(peacefull)


func _on_RatLord_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		owner.get_node("UI").show_text(speech)
		if peacefull == true:
			if get_parent().has_node("SecretPassage"):
				get_parent().get_node("SecretPassage").open_passage()


func _on_RatLord_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		owner.get_node("UI").hide_text()
