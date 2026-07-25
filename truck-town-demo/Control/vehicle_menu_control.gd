extends Control

const PLAYER_COUNT: int = 4
const CHOICE_COUNT: int = 4
const CHANGE_COOLDOWN_MS: int = 200

var vehicle_choice: Array[int] = [1, 2, 3, 4]
var player_choice: Array[int] = [0, 0, 0, 0]
var player_choice_locked: Array[bool] = [false, false, false, false]
var player_last_change_time: Array[int] = [0, 0, 0, 0]

var town: Node3D = null

@export var loading_screen: PanelContainer

@export var player_choice_outlines: Array[Control]
@export var choice_locations: Array[Control]
@export var player_choice_labels: Array[Label]


func _ready() -> void:
	await get_tree().create_timer(.2).timeout
	for player_index in PLAYER_COUNT:
		change_player_choice(player_index, 0)
		move_player_outline(player_index)		


func _input(event: InputEvent) -> void:
	if not event is InputEventJoypadButton and not event is InputEventJoypadMotion:
		return

	var player_index: int = event.device

	if player_index < 0 or player_index >= PLAYER_COUNT:
		return

	if player_choice_locked[player_index]:
		return

	if event.is_action_pressed("ui_right"):
		try_change_player_choice(player_index, 1)

	elif event.is_action_pressed("ui_left"):
		try_change_player_choice(player_index, -1)

	elif event.is_action_pressed("ui_accept"):
		lock_player_choice(player_index)


func try_change_player_choice(player_index: int, direction: int) -> void:
	var current_time: int = Time.get_ticks_msec()
	var time_since_last_change: int = current_time - player_last_change_time[player_index]

	if time_since_last_change < CHANGE_COOLDOWN_MS:
		return

	if change_player_choice(player_index, direction):
		player_last_change_time[player_index] = current_time


func change_player_choice(player_index: int, direction: int) -> bool:
	var new_choice: int = player_choice[player_index] + direction

	if new_choice < 0 or new_choice >= CHOICE_COUNT:
		return false

	player_choice[player_index] = new_choice
	move_player_outline(player_index)

	return true


func move_player_outline(player_index: int) -> void:
	var choice_index: int = player_choice[player_index]

	if player_index >= player_choice_outlines.size():
		return

	if choice_index >= choice_locations.size():
		return

	player_choice_outlines[player_index].global_position = \
		choice_locations[choice_index].global_position + Vector2(75.0,350.0)


func lock_player_choice(player_index: int) -> void:
	if player_choice_locked[player_index]:
		return

	player_choice_locked[player_index] = true

	if player_index < player_choice_labels.size():
		if not player_choice_labels[player_index].text.ends_with(" 🔒"):
			player_choice_labels[player_index].text += " 🔒"

	print(
		"Player ",
		player_index + 1,
		" selected vehicle ",
		vehicle_choice[player_choice[player_index]]
	)

	if all_players_locked():
		start_game()


func all_players_locked() -> bool:
	for locked in player_choice_locked:
		if not locked:
			return false

	return true


func start_game() -> void:
	print("All players locked. Starting game.")
	
func _load_scene(car_scene: PackedScene) -> void:
	# Show loading screen and wait for it to be rendered
	loading_screen.visible = true
	await RenderingServer.frame_post_draw

	var car: Node3D = car_scene.instantiate()
	car.name = "car"
	town = preload("res://town/town_scene.tscn").instantiate()


	town.setup()

	get_parent().add_child(town)
	hide()
