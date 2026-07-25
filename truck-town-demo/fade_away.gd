extends Panel

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	create_tween().tween_property(self, "modulate:a", 0.0, 2.0)
