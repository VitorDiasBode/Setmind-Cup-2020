extends Node2D

var player
var player_initial_pos

func _ready():
	if has_node("Player"):
		player = $Player
		player_initial_pos = player.global_position
		
	if has_node("Ref"):
		get_node("Ref").hide()
		$Player/Player_Sounds.volume_db = -30

func _process(delta: float) -> void:
	if has_node("Player"):
		if $Player.global_position.x < 0:
			$Player.global_position.x = 0

func _on_Bonfire_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player_initial_pos = player.global_position

func _on_HazardObject_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player.global_position = player_initial_pos

func _on_ForestCrystal_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		Global.has_forest_crystal = true
		$ForestCrystal.queue_free()
