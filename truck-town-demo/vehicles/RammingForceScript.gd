extends Area3D

@export var force: Vector3 = Vector3(0, 20, 0)


func _on_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		var offset: Vector3 = global_position - body.global_position
		body.apply_impulse(force, offset)
