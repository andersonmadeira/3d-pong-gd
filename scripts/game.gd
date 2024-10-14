extends Node3D
class_name Game

func _on_score_area_body_entered(body: Node3D) -> void:
	if body is Ball:
		body._reset()