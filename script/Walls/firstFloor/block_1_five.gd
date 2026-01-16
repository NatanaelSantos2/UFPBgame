extends Node2D

@onready var tile_map_layer: TileMapLayer = $TileMapLayer

@export var alpha_fade := 0.3

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_fade_out()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_fade_in()

func _fade_out() -> void:
	var c := tile_map_layer.modulate
	c.a = alpha_fade
	tile_map_layer.modulate = c

func _fade_in() -> void:
	var c := tile_map_layer.modulate
	c.a = 1.0
	tile_map_layer.modulate = c
