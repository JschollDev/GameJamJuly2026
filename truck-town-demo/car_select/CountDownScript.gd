extends Panel

@export var countdown_label: Label
@export var next_scene: PackedScene

func _ready() -> void:
	hide()
	
	GameManager.state_changed.connect(_on_state_changed)


func _on_state_changed(new_state: GameManager.State) -> void:
	if new_state != GameManager.State.GET_READY:
		return
	show()

	for number: int in range(3, 0, -1):
		countdown_label.text = str(number)
		await get_tree().create_timer(1.0).timeout

	get_tree().change_scene_to_packed(next_scene)
