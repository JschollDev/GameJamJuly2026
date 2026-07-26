extends Node

@export var vehicles: Array[Node]
@export var cameras: Array[Camera3D]
@export var vehicleBodies: Array[VehicleBody3D]
@export var SubViews: Array[SubViewportContainer]
@onready var count_down: Panel = $CountDown

var dead: int = 0
var player_dead: = [false,false,false,false]
var winner: int
var game_active: bool = true


func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)

	for id in 4:
		vehicleBodies.append(vehicles[id]._set_player_id(id))
		
	for views in 4:
		vehicleBodies[views].viewportcover = SubViews[views]
	
	for cam in 4:
		cameras[cam]._set_target(vehicleBodies[cam])
	
	GameManager.change_state(GameManager.State.PLAY)

func _on_state_changed(new_state: GameManager.State) -> void:
	game_active = new_state == GameManager.State.PLAY


func _physics_process(_delta: float) -> void:
	if not game_active:
		return
	
	for player in 4:
		if not vehicleBodies[player].input_enabled and not player_dead[player]:
			player_dead[player] = true 
			SubViews[player].update_spec_cam()
			dead = dead + 1
		if dead == 3 and not player_dead[player]:
			GameManager.winner = player + 1
			GameManager.change_state(GameManager.State.WIN)
