tool
extends StaticBody2D

export var vine_height = 64.0 setget set_vine_height

func set_vine_height(height):
	vine_height = height
	$Area2D/CollisionShape2D.shape.extents.y = height
	$CollisionShape2D.shape.extents.y = height
	
