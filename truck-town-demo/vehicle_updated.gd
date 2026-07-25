extends VehicleBody3D

const STEER_SPEED = 1.5
const STEER_LIMIT = 0.4
const BRAKE_STRENGTH = 2.0

@export var controller_id: int = 0
@export var engine_force_value := 40.0

var previous_speed := linear_velocity.length()
var _steer_target := 0.0
var is_compatibility := RenderingServer.get_current_rendering_method() == "gl_compatibility"


func _physics_process(delta: float) -> void:
	_steer_target = Input.get_axis(&"turn_right", &"turn_left")
	_steer_target *= STEER_LIMIT

	
	engine_force *= Input.get_action_strength(&"accelerate")

	if Input.is_action_pressed(&"reverse"):
		# Increase engine force at low speeds to make the initial reversing faster.
		var speed := linear_velocity.length()
		if speed < 5.0 and not is_zero_approx(speed):
			engine_force = -clampf(engine_force_value * 5.0 / speed, 0.0, 100.0)
		else:
			engine_force = -engine_force_value

		# Apply analog brake factor for more subtle braking if not fully holding down the trigger.
		engine_force *= Input.get_action_strength(&"reverse")

	steering = move_toward(steering, _steer_target, STEER_SPEED * delta)

	previous_speed = linear_velocity.length()
