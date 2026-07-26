extends Panel

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
