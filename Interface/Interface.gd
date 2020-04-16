extends Control

func update_ui(values:Dictionary):
	for value in values:
		if value == "Life":
			$Panel/TextureProgress.value = values.get(value)
		else:
			get_node("Panel/HBoxContainer/"+value+"/Label").text = str(values.get(value))
		
	
