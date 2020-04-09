extends Node2D

var quest_talk_to_arnold = false
var quest_fix_elevator = false
var quest_destroy_all = false
var destroyed_buildings = 0

var elevator_man_old_speech = ""

func _ready() -> void:
	$Player.fire_skill = 0
	$NPCs/Tower/SunCrystal/Sprite.texture = null
	$Catacombs/MoonCrystal/Sprite.texture = null

func _process(delta: float) -> void:
	if quest_destroy_all:
		$Player.modulate = lerp($Player.modulate , Color(1,1,1) , 0.07)

func _on_Moses_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		quest_talk_to_arnold = true
		$NPCs/RustyNail/Arnold.speech = "Arnold: Hum… Então Moses te enviou? Certo, eis o plano: Cavamos um túnel até o subterrâneo da Torre Branca. Lá achamos o Cristal da Lua que energiza metade dos Guardiões de Goven. Só que está protegido por armadilhas. Já perdemos dois homens neste buraco! Se você é tão bom quando dizem, você deve atravessar as armadilhas antes de anoitecer e destruir o Cristal. Assim que destruir, nós vamos saber que você conseguiu. Fuja pelo Portão da Lua, ao Leste e nos encontre fora da cidade."

func _on_Arnold_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if quest_talk_to_arnold == true:
			$Walls/FakeWall/AnimationPlayer.play("Fade")
			$Walls/FakeWall.open_passage()


func _on_CristalTraps_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$Player.global_position = Vector2(4016,1248)
		$Catacombs/MoonCrystal/CollisionShape2D.set_deferred("disabled",false)
		$AnimationPlayer.play("Day")
		$NPCs/RustyNail.global_position.y = 0
		$Tower/ElevatorAnchor.position.y = 0
		$NPCs/SunGuardians.global_position.y = 0
		$NPCs/MoonGuardians.global_position.y = 0
		$NPCs/GoldenPlaza.global_position.y = 0
		$Gates.restore_moon_gate()
		$NPCs/DisabledGuardians.hide()
		$People.hide()
		$Tower/Roll.activate(false)
		$TimerFire.stop()
		$Player.fire_skill = 0
		$Player.modulate = Color(1,1,1)
		destroyed_buildings = 0
		get_tree().call_group("builds","rebuild")
		$NPCs/Tower/SunCrystal/CollisionShape2D.call_deferred("disabled",false)
		$NPCs/Tower/ElevatorMan.speech = elevator_man_old_speech
		$NPCs/ProtectingGuardians.hide()
		$Catacombs/MoonCrystal/Crystal2/AnimationPlayer.play("Float")
		


func _on_ElevatorMan_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		quest_fix_elevator = true
		$NPCs/GoldenPlaza/Boris.speech = "Boris: Ha, estes humanos sempre serão inferiores, não importa se passam ou não na prova. Vou enviar meus auxiliares para consertar a peça do elevator."

func _on_Boris_body_entered(body: Node) -> void:
	if quest_fix_elevator:
		$NPCs/Tower/ElevatorMan.speech = "Superior: Ah! Obrigado Arcano! Agora o Elevador está funcionando e você pode ver o grande e bondoso Lorde Goven. Mas por favor, não fale nada do que aconteceu aqui.. Lorde Goven é bondoso, mas sua tolerancia é severa..."
		$Tower/ElevatorAnchor/Elevator.speed = 100
		$Tower/ElevatorAnchor/Elevator.motion = Vector2(0,-1)
		$Tower/Roll.activate(true)

func _on_SunCrystal_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$NPCs/Tower/Goven.speech = "Goven: Eu sei que você vai para em direção ao norte Arcano. As estradas para lá são perigosas. Você viu o portal que eu Construí na minha cidade? Se você realizar minha vontade, você poderá usar o portal e chegar ao seu destino brevemente. Vá! Meu nobre Arcano, cumpra sua missão!"
		quest_destroy_all = true
		$AnimationPlayer.play("Night")
		$NPCs/RustyNail.global_position.y = -9000
		$TimerFire.start(3)

func _on_SunCrystal_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		$NPCs/Tower/SunCrystal/CollisionShape2D.call_deferred("disabled",true)

func _on_TimerFire_timeout() -> void:
	$Player.fire_skill += 10
	$Player.modulate = Color(1,0,0)

#############Importante################
func _destroyed() -> void:
	destroyed_buildings += 1
	if destroyed_buildings >= 14:
		$Portal.activate(true)
		$NPCs/Tower/Goven.speech = "Goven: Perfeito Arcano. Eu vi os fogos e destruição daqui de cima da torre. Belo e perfeito! Você tem o que precisa para ser um Grande Líder! Pulso firme e não há um pingo de hesitação ou remorso em você. Você fez o que é necessário para o bem maior e de todos. O portal está aberto para o seu uso nobre Arcano."


func _on_MoonCrystal_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$Catacombs/MoonCrystal/Crystal2/AnimationPlayer.play("Fade")

func _on_MoonCrystal_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		$Catacombs/MoonCrystal/CollisionShape2D.set_deferred("disabled",true)
		$AnimationPlayer.play("Night")
		$NPCs/RustyNail.global_position.y = - 9000
		$Tower/ElevatorAnchor.position.y = -9000
		$NPCs/SunGuardians.global_position.y = -9000
		$NPCs/MoonGuardians.global_position.y = -9000
		$NPCs/GoldenPlaza.global_position.y = -9000
		$Gates.destroy_moon_gate()
		$NPCs/DisabledGuardians.show()
		$People.show()
		$Tower/Roll.activate(false)
		$TimerFire.stop()
		$Player.fire_skill = 0
		$Player.modulate = Color(1,1,1)
		destroyed_buildings = 0
		get_tree().call_group("builds","rebuild")
		$NPCs/Tower/SunCrystal/CollisionShape2D.call_deferred("disabled",false)
		elevator_man_old_speech = $NPCs/Tower/ElevatorMan.speech
		$NPCs/Tower/ElevatorMan.speech = "Superior: Senhor Arcano, o caos aconteceu! Os Inferiores invadiram do nada a parte Leste da cidade e todos os Guardiões da Lua pararam de funcionar. As pessoas destruíram o portão da Lua e saíram da cidade. Somente os Guardiões do Sol estão funcionando. Nosso trabalho é proteger Lorde Goven com nossas vidas, ninguém pode subir na Torre. Infelizmente nem o senhor..."
		$NPCs/ProtectingGuardians.show()
