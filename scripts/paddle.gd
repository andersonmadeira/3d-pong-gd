extends CharacterBody3D
class_name Paddle

@onready var score_ui: ScoreUI = $ScoreUI

@export var move_up_action: String = ''
@export var move_down_action: String = ''
@export var speed := 20.0

func _physics_process(_delta: float) -> void:
	var dir = get_movement_direction()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if dir:
		velocity.x = dir * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func get_movement_direction() -> int:
	if Input.is_action_pressed(move_up_action):
		return -1
	
	if Input.is_action_pressed(move_down_action):
		return 1

	return 0

func _on_score_area_body_entered(body: Node3D) -> void:
	if body is Ball:
		score_ui.score = score_ui.score + 1
		body.destroy()
