extends CharacterBody3D
class_name Paddle

@onready var score_ui: Sprite3D = $ScoreUI
@onready var score_label: Label = $ScoreUI/SubViewport/Control/Label

@export var move_up_action: String = ''
@export var move_down_action: String = ''
@export var speed := 20.0

var direction := 0

func _ready() -> void:
	score_ui.global_position += Vector3(global_position.x, 0, global_position.z) + 3 * transform.basis.z

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
		score_label.text = str(int(score_label.text) + 1)
		body.destroy()