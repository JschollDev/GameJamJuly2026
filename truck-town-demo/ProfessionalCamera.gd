extends Camera3D

@export var target: Node3D
@export var follow_speed: float = 5.0
@export var look_ahead_time: float = 0.2
@export var follow_height: float = 3.5
@export var follow_distance: float = 5.0
@export var ground_clearance: float = 1.0

@onready var ground_ray: RayCast3D = $RayCast3D

var previous_target_position: Vector3


func _ready() -> void:
	if target != null:
		previous_target_position = target.global_position


func _set_target(passed_target: Node3D) -> void:
	target = passed_target
	previous_target_position = target.global_position


func _physics_process(delta: float) -> void:
	if target == null:
		return

	var target_velocity: Vector3 = (
		target.global_position - previous_target_position
	) / max(delta, 0.001)

	previous_target_position = target.global_position

	var desired_position: Vector3 = (
		target.global_position
		+ -target.global_basis.z * follow_distance
		+ Vector3.UP * follow_height
	)

	global_position = global_position.lerp(
		desired_position,
		1.0 - exp(-follow_speed * delta)
	)

	ground_ray.force_raycast_update()

	if ground_ray.is_colliding():
		var ground_y: float = ground_ray.get_collision_point().y
		global_position.y = max(global_position.y, ground_y + ground_clearance)

	var future_position: Vector3 = (
		target.global_position
		+ target_velocity * look_ahead_time
	)

	look_at(future_position, Vector3.UP)
