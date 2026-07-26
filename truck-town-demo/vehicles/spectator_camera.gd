extends Camera3D

func _ready() -> void:
	GameManager.spectation_camera = self
