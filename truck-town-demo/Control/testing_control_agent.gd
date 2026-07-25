extends Node3D

@export var p1_mesh: MeshInstance3D
@export var p2_mesh: MeshInstance3D
@export var p3_mesh: MeshInstance3D
@export var p4_mesh: MeshInstance3D

var mesh_array: Array

func _ready() -> void:
	mesh_array = [p1_mesh,p2_mesh,p3_mesh,p4_mesh]
	pass

func _input(event: InputEvent) -> void:
	if not event is InputEventJoypadButton and not event is InputEventJoypadMotion:
		return
	if not event.is_action_pressed("accelerate"):
		return
	print(str(event.device))
	
	mesh_array[event.device].set_active()
	
