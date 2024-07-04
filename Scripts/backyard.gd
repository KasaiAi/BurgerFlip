extends Node3D

var is_dragging = false
var mouse_pos = Vector2()

func _input(event):
	if event.is_action_pressed("click"):
		print("click")
		var collision = get_world_3d().get_direct_space_state().intersect_ray(PhysicsRayQueryParameters3D.create(transform.origin, Vector3(0, 0, -20)))
		
		if collision:
			print(collision.position)
			if collision.collider == "Borgar2":
				is_dragging = true
	
	if event.is_action_released("click"):
		is_dragging = false

func _process(delta):
	if is_dragging:
		var new_pos = get_viewport().get_mouse_position() - mouse_pos
		set_position(new_pos)

func raycast_object():
	var spaceState = get_world_3d().get_direct_space_state()
	var mousePos = get_viewport().get_mouse_position()
	var camera = $Camera3D
	
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 200
	
	var intersect = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var ray = spaceState.intersect_ray(intersect)
	
	if ray:
		return ray.collider.getparent()
