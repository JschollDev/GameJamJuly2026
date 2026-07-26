extends Node3D

@export var rotation_speed: float = 1.0
@export var rumble_amount: float = 0.03
@export var rumble_interval: float = 2.0

var start_position: Vector3


func _ready() -> void:
	start_position = position
	rumble()


func _process(delta: float) -> void:
	rotate_y(rotation_speed * delta)


func rumble() -> void:
	while true:
		await get_tree().create_timer(rumble_interval).timeout

		var tween: Tween = create_tween()
		tween.tween_property(
			self,
			"position",
			start_position + Vector3(
				randf_range(-rumble_amount, rumble_amount),
				randf_range(-rumble_amount, rumble_amount),
				randf_range(-rumble_amount, rumble_amount)
			),
			0.05
		)
		tween.tween_property(self, "position", start_position, 0.1)
