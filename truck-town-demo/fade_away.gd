extends Panel

@export var fade_time:float = 3.0

func _ready() -> void:
	await get_tree().create_timer(fade_time).timeout
	create_tween().tween_property(self, "modulate:a", 0.0, 2.0)
