extends VehicleBody3D

@export var repel_force := 10000.0

func _physics_process(delta):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body is VehicleBody3D:
			var dir = (body.global_position - global_position).normalized()
			body.apply_central_force(dir * repel_force)
