extends CharacterBody3D
class_name Ball

@export var min_start_angle := 30.0
@export var max_start_angle := 70.0

@onready var debug_mesh: MeshInstance3D = $DebugMesh

const SPEED = 15.0

var rand := RandomNumberGenerator.new()

var _direction := Vector3.ZERO

func _ready() -> void:
	_reset()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("generate"):
		_reset()

## Generates a random
func _reset() -> void:
	global_position.z = 0
	global_position.x = 0

	# debug_mesh.global_position = _get_random_direction() * 5
	_direction = _get_random_direction()

func _get_random_direction() -> Vector3:
	var xDirection = -1 if rand.randf() >= 0.5 else 1
	var yDirection = -1 if rand.randf() >= 0.5 else 1
	var angle = rand.randf_range(min_start_angle, max_start_angle)

	var x = cos(deg_to_rad(angle)) * xDirection
	var y = sin(deg_to_rad(angle)) * yDirection

	return Vector3(x, global_position.y, y)
	
func _physics_process(_delta: float) -> void:
	velocity.x = _direction.x * SPEED
	velocity.z = _direction.z * SPEED

	move_and_slide()
