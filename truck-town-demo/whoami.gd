extends SubViewportContainer

@export var spec_camera: Camera3D
@export var main_cam: Camera3D
@export var flash_color: Color = Color.RED
@export var flash_time: float = 0.3

@onready var shader: ShaderMaterial = material as ShaderMaterial


func _ready() -> void:
	shader.set_shader_parameter("flash_color", flash_color)


func flash() -> void:
	shader.set_shader_parameter("flash_strength", 1.0)

	var tween: Tween = create_tween()
	tween.tween_method(
		func(value: float) -> void:
			shader.set_shader_parameter("flash_strength", value),
		1.0,
		0.0,
		flash_time
	)

func update_spec_cam() -> void:
	if main_cam:
		main_cam.queue_free()
	#spec_camera.current = true
	
	
