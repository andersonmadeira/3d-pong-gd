extends Node3D
class_name ScoreUI

@onready var label: Label = $SubViewport/Control/Label

var value: int:
	get:
		return int(label.text)

func increase() -> int:
	var new_val = value + 1
	label.text = str(new_val)
	return new_val

func _reset() -> void:
	label.text = "0"
