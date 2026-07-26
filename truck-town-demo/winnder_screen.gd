extends Panel


@export var next_scene: PackedScene
@export var winner_label: Label


func _ready() -> void:
	hide()
	GameManager.state_changed.connect(_on_state_changed)


func _on_state_changed(new_state: GameManager.State) -> void:
	if new_state != GameManager.State.WIN:
		return

	show_winner(GameManager.winner)


func show_winner(x: int) -> void:
	winner_label.text = "Player #%s Wins!" % x
	show()

	await get_tree().create_timer(3.0).timeout

	GameManager.current_state = GameManager.State.SELECTION_SCREEN
	GameManager.winner = 0
	get_tree().change_scene_to_packed(next_scene)
