extends Node3D
class_name ScoreUI

@onready var label: Label = $SubViewport/Control/Label

var score: int:
	get:
		return int(label.text)
	set(value):
		label.text = str(value)
