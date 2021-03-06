tool
extends Area2D

export (Texture) var sprite setget set_texture

export (String, MULTILINE)var speech = ""

export (bool) var mirror setget set_mirror

func _on_GenericNPC_body_entered(body):
	if body.is_in_group("Player"):
		owner.get_node("UI").show_text(speech)

func _on_GenericNPC_body_exited(body):
	if body.is_in_group("Player"):
		owner.get_node("UI").hide_text()

func set_texture(tex):
	sprite = tex
	$Sprite.texture = tex
	
func set_mirror(dir):
	mirror = dir
	$Sprite.flip_h = dir
