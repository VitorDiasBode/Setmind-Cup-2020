extends Node2D 

var load_level

func _ready():
	load_level = load( "res://Test_Level.tscn" )
	Audio.change_music()

func _on_Button_pressed():
	get_tree().change_scene_to(load_level)
