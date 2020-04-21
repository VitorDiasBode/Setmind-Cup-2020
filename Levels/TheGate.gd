extends Node2D

var thePlain = load("res://Levels/ThePlains.tscn")

func _ready() -> void:
	if has_node("Player"):
		$Player/Camera2D.current = false

func _on_AnimatedSprite_animation_finished() -> void:
	$Mage/AnimatedSprite.play("Idle")
	pass # Replace with function body.


func _on_Mage_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		if Global.has_forest_crystal:
			$PortalMage.activate(true)
			$Mage/AnimatedSprite.play("Cast")
			


func _on_Mage_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if Global.has_forest_crystal:
			$Mage/AnimatedSprite.flip_h = false
			$Mage.speech = "Ah! Você trouxe meu Cristal Precioso! Meu Precioso! \n\nAhem... Vou abrir o portal para você Arcano.\nVá e me deixe em paz com o meu Precioso."


func _on_ThePlains_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to(thePlain)
