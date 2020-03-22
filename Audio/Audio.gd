extends Node2D


func change_music():
	var load_stream
	match get_parent().get_child(1).name:
		"Test_Level":
			load_stream = load("res://Audio/Test_Level_music.wav")
		"Menu":
			load_stream = load("res://Audio/Menu_Music.wav")

	$Music_Level.stream = load_stream
	$Music_Level.play()
	
func _on_Music_Level_finished():
	$Music_Level.play()
