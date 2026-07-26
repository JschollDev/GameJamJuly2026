extends Node

@export var vehicles: Array[PackedScene]
@export var cameras: Array[Camera3D]
@export var vehicleBodies: Array[VehicleBody3D]
@export var spawn_points: Array[Node3D]
@export var SubViews: Array[SubViewportContainer]
@onready var count_down: Panel = $CountDown

var dead: int = 0
var player_dead: = [false,false,false,false]
var winner: int
var game_active: bool = true

var spawned_vehicles: Array[Node] = []

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	spawn_vehicles()
	GameManager.change_state(GameManager.State.PLAY)

func _grab_player_vehicle_choice() -> void:
	pass

func spawn_vehicles() -> void:
	for player in 4:
		var player_vehicle_choice: int = GameManager._grab_player_vehicle_choice(player)
		var vehicle: Node = vehicles[player_vehicle_choice].instantiate()
		add_child(vehicle)
		vehicle.global_transform = spawn_points[vehicle].global_transform
		spawned_vehicles.append(vehicle)
		vehicleBodies.append(spawned_vehicles[player]._set_player_id(player))
		vehicleBodies[player].viewportcover = SubViews[player]
		cameras[player]._set_target(vehicleBodies[player])

func _on_state_changed(new_state: GameManager.State) -> void:
	game_active = new_state == GameManager.State.PLAY

	if new_state == GameManager.State.WIN:
		await get_tree().create_timer(2.0).timeout
		GameManager.change_state(GameManager.State.SELECTION_SCREEN)
		get_tree().change_scene_to_file("res://vehicle_control.tscn")
		

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
