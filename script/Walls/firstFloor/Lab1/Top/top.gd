extends Node2D

@onready var player: CharacterBody2D = $"../../../../../Player"


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player.z_index = -1

func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.is_in_group("player"):
			player.z_index = 0
