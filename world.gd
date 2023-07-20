extends Node2D

@onready var polygon_2d: Polygon2D = $StaticBody2D/CollisionPolygon2D/Polygon2D


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.CORNFLOWER_BLUE)
	polygon_2d.color = Color.ALICE_BLUE
