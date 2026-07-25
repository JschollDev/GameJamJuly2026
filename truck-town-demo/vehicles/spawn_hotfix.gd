extends Node3D

@onready var body: VehicleBody3D = $Body

func _set_player_id(id_pass: int) -> VehicleBody3D: 
	body._set_controller_id(id_pass)
	return body
