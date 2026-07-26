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
var game_active: bool = false

var spawned_vehicles: Array[Node3D]

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	spawn_vehicles()
	GameManager.change_state(GameManager.State.PLAY)

func _grab_player_vehicle_choice() -> void:
	pass

func spawn_vehicles() -> void:
	for player in 4:
		print('spawning player'+str(player))
		var player_vehicle_choice: int = GameManager._grab_player_vehicle_choice(player)
		print('player '+str(player)+' choice is '+str(player_vehicle_choice))
		var vehicle: Node3D = vehicles[player_vehicle_choice].instantiate()
		add_child(vehicle)
		spawned_vehicles.append(vehicle)
		vehicleBodies.append(spawned_vehicles[player]._set_player_id(player))
		print('setting Vehicle Bodies from player index'+str(player))
		#await get_tree().create_timer(1).timeout
		
		var temp_spawn_ref:Node3D = spawn_points[player]
		vehicleBodies[player].set_spawn_location(temp_spawn_ref)
		print(player)
		print(vehicleBodies[player])
		print(SubViews[player])
		vehicleBodies[player].viewportcover = SubViews[player]
		cameras[player]._set_target(vehicleBodies[player])
		if player == 3:
			game_active = true
	

func _on_state_changed(new_state: GameManager.State) -> void:

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
