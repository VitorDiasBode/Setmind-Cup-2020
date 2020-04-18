extends Node2D


func _ready():
	if has_node("Ref"):
		get_node("Ref").hide()
