extends CanvasLayer

func _ready():
	get_tree().paused = false
	$Menu_Options.hide()

func _on_Button_Restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	$Menu_Options.hide()

func _input(event):
	if event.is_action_pressed("ui_select"):
		if get_tree().paused:
			get_tree().paused = false
			$Menu_Options.hide()
		else:
			get_tree().paused = true
			$Menu_Options.show()

func show_text(text:String):
	$Messages/Panel/Text_Area.text = ""
	$Messages/Panel.show()
	
	for character in text:
		yield(get_tree().create_timer(0.09), "timeout")
		$Messages/Panel/Text_Area.text += character

func hide_text():
	$Messages/Panel.hide()

func restart_level():
	get_tree().reload_current_scene()
