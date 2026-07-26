extends Node

signal state_changed(new_state: State)
var spectation_camera: Camera3D
var winner: int = -1

enum State {
	SELECTION_SCREEN,
	GET_READY,
	PLAY,
	WIN
}

var current_state: State = State.SELECTION_SCREEN

func change_state(new_state: State) -> void:
	if current_state == new_state:
		return

	current_state = new_state
	state_changed.emit(current_state)
	check_stuff()

	if current_state == State.WIN:
		await get_tree().create_timer(3.0).timeout
		change_state(State.SELECTION_SCREEN)
	
func  check_stuff() -> void:
	print(GameManager.State.keys()[GameManager.current_state])
	#if current_state == GameManager.State.SELECTION_SCREEN:
		#winner = -1
	
