extends Node2D

@onready var point_light_2d: PointLight2D = $PointLight2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var tween = create_tween()
		tween.tween_property(point_light_2d, "energy", 0 ,1)
