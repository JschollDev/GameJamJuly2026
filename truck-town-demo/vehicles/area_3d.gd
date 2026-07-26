extends Area3D

# Adjustable force strength in the Inspector
@export var force_strength: float = 50000.0

func _ready() -> void:
	# Automatically connect the signal if not done in the editor
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: VehicleBody3D) -> void:
	# Ensure the body is a VehicleBody3D or RigidBody3D
	print("Area SIgnal CaLeD")
	if body is VehicleBody3D:
		# Calculate the point of impact relative to the vehicle's center
		var relative_position: Vector3 = global_position - body.global_position
		
		# Define the upward force vector
		var force_vector: Vector3 = Vector3(force_strength, force_strength, force_strength)
		
		# Apply the force at the relative collision point
		body.apply_force(force_vector, relative_position)
		print("Verified body attempt force")
