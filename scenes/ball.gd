extends CharacterBody3D
class_name Ball

@export var min_start_angle := 30.0
@export var max_start_angle := 70.0
@export var speed := 30.0

@onready var debug_mesh: MeshInstance3D = $DebugMesh

var rand := RandomNumberGenerator.new()
var _velocity := Vector3.ZERO

func _ready() -> void:
	_reset()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("generate"):
		_reset()

## Generates a random
func _reset() -> void:
	visible = true

	global_position.z = 0
	global_position.x = 0

	# debug_mesh.global_position = _get_random_direction() * 5
	var direction = _get_random_direction()

	_velocity.x = direction.x * speed
	_velocity.z = direction.z * speed

func _get_random_direction() -> Vector3:
	var xDirection = -1 if rand.randf() >= 0.5 else 1
	var yDirection = -1 if rand.randf() >= 0.5 else 1
	var angle = rand.randf_range(min_start_angle, max_start_angle)

	# Get x,y coords given the angle
	var x = cos(deg_to_rad(angle)) * xDirection
	var y = sin(deg_to_rad(angle)) * yDirection

	return Vector3(x, global_position.y, y)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(_velocity * delta)

	# If we collided with something, bounce off
	if collision:
		_velocity = _velocity.bounce(collision.get_normal())

func _destroy() -> void:
	visible = false