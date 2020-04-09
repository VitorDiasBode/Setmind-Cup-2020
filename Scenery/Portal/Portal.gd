extends Area2D

export (PackedScene) var level
var next_level
export var active = true

func _ready():
	next_level = load(level.get_path())
	activate(active)

func _process(delta):
	if active:
		$BG.rotate(2 * delta)

func activate(trigger):
	active = trigger
	$BG.visible = trigger

func _on_Portal_body_entered(body):
	if body.is_in_group("Player"):
		if active:
			get_tree().change_scene_to(next_level)
