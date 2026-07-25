extends Camera3D

@export var target_parent: Node
@export var follow_speed: float = 2.0

var target: Node3D
var follow_offset: Vector3


func _ready() -> void:
	top_level = true

	await get_tree().create_timer(0.5).timeout

	if target_parent == null:
		return

	target = target_parent.get_child(0) as Node3D

	if target == null:
		print("Target child is not a Node3D")
		return

	follow_offset = global_position - target.global_position
	print("Following: ", target.name)


func _physics_process(delta: float) -> void:
	if target == null:
		return

	var desired_position: Vector3 = target.global_position + follow_offset
	desired_position.y += 2

	global_position = global_position.lerp(
		desired_position,
		1.0 - exp(-follow_speed * delta)
	)

	look_at(target.global_position, Vector3.UP)
