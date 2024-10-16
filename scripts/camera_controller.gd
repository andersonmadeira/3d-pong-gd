extends Node3D

@export var invert_x = false
@export var invert_y = false
@export var yaw_rotation_speed: float = 300
@export var pitch_rotation_speed: float = 200
@export var yaw_acceleration: float = 50
@export var pitch_acceleration: float = 120
@export var pitch_max_angle: float = 0
@export var pitch_min_angle: float = -120
@export var mouse_sensitivity: float = 0.07

@onready var inner_gimbal = $InnerGimbal
@onready var camera = $InnerGimbal/SpringArm3D/Camera3D

var yaw := 0.0
var pitch := 0.0
var is_mouse_pressed := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_handle_action_input()
	_update_angles(delta)
	
func _update_angles(delta: float) -> void:
	pitch = clampf(pitch, pitch_min_angle, pitch_max_angle)
	
	rotation_degrees.y = lerp(rotation_degrees.y, yaw, yaw_acceleration * delta)
	inner_gimbal.rotation_degrees.x = lerp(rotation_degrees.x, pitch, pitch_acceleration * delta)

# Handle camera input keys
func _handle_action_input() -> void:
	var delta = get_process_delta_time()
	var yaw_input = -1 * Input.get_axis("camera_rotate_left", "camera_rotate_right")
	
	if yaw_input:
		var dir = -1 if invert_x else 1
		yaw += yaw_input * yaw_rotation_speed * delta * dir
	
	var pitch_input = -1 * Input.get_axis("camera_rotate_up", "camera_rotate_down")
	
	if pitch_input:
		var dir = -1 if invert_y else 1
		pitch += pitch_input * pitch_rotation_speed * delta * dir

# Handle mouse control of the camera by capturing unhandled mouse input
func _unhandled_input(event: InputEvent) -> void:
	# activate or deactivate mouse to control the camera
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		is_mouse_pressed = event.is_pressed()
		
		# Hide mouse if player pressed mouse, show otherwise
		if is_mouse_pressed:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	# Handle mouse movement to control the camera, but only if it was activated by right mouse button
	if is_mouse_pressed and event is InputEventMouseMotion:
		var dir_yaw = -1 if invert_x else 1
		yaw += -event.relative.x * mouse_sensitivity * dir_yaw
		var dir_pitch = -1 if invert_y else 1
		pitch += -event.relative.y * mouse_sensitivity * dir_pitch