extends Node

@export var vehicles: Array[Node]
@export var cameras: Array[Camera3D]
@export var vehicleBodies: Array[VehicleBody3D]
@export var SubViews: Array[SubViewportContainer]

func _ready() -> void:
	for id in 4:
		vehicleBodies.append(vehicles[id]._set_player_id(id))
		
	for views in 4:
		vehicleBodies[views].viewportcover = SubViews[views]
	
	for cam in 4:
		cameras[cam]._set_target(vehicleBodies[cam])
