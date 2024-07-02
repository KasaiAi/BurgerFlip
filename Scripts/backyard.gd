extends Node3D

var is_dragging = false
var mouse_pos = Vector2()

func _input(event):
	if event.is_action_pressed("click"):
#		var from = $RayCast.global_transform.origin
#		var to = from + $RayCast.global_transform.basis.z * 100.0
		print("click")
		var collision = get_world_3d().direct_space_state.intersect_ray(PhysicsRayQueryParameters3D.create(transform.origin, Vector3(0, 0, -20)))
		
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
