extends AudioStreamPlayer

var audio_list = {
	"FireBall": load("res://Player/Audios/FireBall.wav"),
	"Damage": load("res://Player/Audios/Damage.wav"), 
	"Jump": load("res://Player/Audios/Jump.wav"),
	"PickUp": load("res://Player/Audios/PickUp.wav"),
	"DrinkCoffee": load("res://Player/Audios/DrinkCoffee.wav")
	}

func play_audio(audio_name):
	stream = audio_list.get(audio_name)
	play()
