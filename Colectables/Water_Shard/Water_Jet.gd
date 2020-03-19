extends Area2D

var growth_scale = 300

func _ready():
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.extents = Vector2(0, 24)

func _physics_process(delta):
	$CollisionShape2D.global_position.x += delta * growth_scale
	$CollisionShape2D.shape.extents.x += delta * growth_scale
	if abs($CollisionShape2D.shape.extents.x) > 300:
		queue_free()
	pass


func _on_Water_Jet_body_entered(body):
	if body.is_in_group("Push"):
		body.movement.x = growth_scale

func _on_Water_Jet_body_exited(body):
	if body.is_in_group("Push"):
		body.movement.x = 0
