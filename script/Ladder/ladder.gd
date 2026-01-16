extends Node2D

@onready var tile_map_top: TileMapLayer = $TileMapTop
@onready var player: CharacterBody2D = $"../../../../../Player"
@onready var second_floor: Node2D = $"../../../../secondFloor"
@onready var point_light_2d: PointLight2D = $"../../../../../Player/PointLight2D"
@onready var tile_map_low: TileMapLayer = $TileMapLow

#Player sobe a escada para cima 
func _on_area_top_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.get_collision_layer_value(1) and body.get_collision_mask_value(1):
		tile_map_top.y_sort_enabled = false
		body.set_collision_mask_value(1, false)
		body.set_collision_mask_value(2, true)
		body.set_collision_layer_value(2, true)
		body.set_collision_layer_value(1, false)

#Player desce a escada e volta aos padores
func _on_area_low_reset_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.is_in_group("player") and tile_map_top.y_sort_enabled == false and body.get_collision_mask_value(2) and  body.get_collision_layer_value(2):
			tile_map_top.y_sort_enabled = true
			player.z_index = 0
			body.set_collision_mask_value(1, true)
			body.set_collision_mask_value(2, false)
			body.set_collision_layer_value(1, true)
			body.set_collision_layer_value(2, false)

func _on_area_top_exit_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.is_in_group("player") and player.z_index == 0:
			player.z_index = 2
		if second_floor.visible == false:
			second_floor.visible = true
			
			#Trata da iluminação, as sombras do pointLight2D
			point_light_2d.range_item_cull_mask = 2
			point_light_2d.shadow_item_cull_mask = 2
		else:
			second_floor.visible = false
			#Trata da iluminação, as sombras do pointLight2D
			point_light_2d.range_item_cull_mask = 1
			point_light_2d.shadow_item_cull_mask = 1
