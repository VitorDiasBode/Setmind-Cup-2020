extends Node2D

var quest_talk_to_arnold = false

func _on_Moses_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		quest_talk_to_arnold = true
		$NPCs/RustyNail/Arnold.speech = "Arnold: Hum… Então Moses te enviou? Certo, eis o plano: Cavamos um túnel até o subterrâneo da Torre Branca. Lá achamos o Cristal da Lua que energiza metade dos Guardiões de Goven. Só que está protegido por armadilhas. Já perdemos dois homens neste buraco! Se você é tão bom quando dizem, você deve atravessar as armadilhas antes de anoitecer e destruir o Cristal. Assim que destruir, nós vamos saber que você conseguiu. Fuja pelo Portão da Lua, ao Leste e nos encontre fora da cidade."

func _on_Arnold_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if quest_talk_to_arnold == true:
			$Walls/FakeWall/AnimationPlayer.play("Fade")
			$Walls/FakeWall.open_passage()


func _on_CristalTraps_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$Player.global_position = Vector2(4016,1248)
