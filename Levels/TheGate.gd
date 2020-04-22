extends Node2D

var thePlain = load("res://Levels/ThePlains.tscn") # Não Precisa

func _ready() -> void: #Não Precisa
	if has_node("Player"):
		$Player/Camera2D.current = false

func _on_AnimatedSprite_animation_finished() -> void: #Não Precisa
	$Mage/AnimatedSprite.play("Idle")
	pass # Replace with function body.

#############PRECISA##################
func _on_Mage_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		if Global.has_forest_crystal:
			$PortalMage.activate(true)
			$Mage/AnimatedSprite.play("Cast") #Não Precisa
			
func _on_Mage_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if Global.has_forest_crystal:
			$Mage/AnimatedSprite.flip_h = false #Não Precisa
			$Mage.speech = "Ah! Você trouxe meu Cristal Precioso! Meu Precioso! \n\nAhem... Vou abrir o portal para você Arcano.\nVá e me deixe em paz com o meu Precioso."
#####################################

func _on_ThePlains_body_entered(body: Node) -> void: #Não Precisa
	if body.is_in_group("Player"):
		get_tree().change_scene_to(thePlain)
