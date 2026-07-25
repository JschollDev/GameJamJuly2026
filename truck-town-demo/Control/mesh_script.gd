extends MeshInstance3D

var base_vec = Vector3(1.0,1.0,1.0)

func _ready() -> void:
	scale = base_vec

func set_active() -> void:
	scale = 1.3 * base_vec
	await get_tree().create_timer(.2).timeout
	scale = 1.0 * base_vec
