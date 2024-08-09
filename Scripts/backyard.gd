extends Node3D

var mouse_pos
var location

signal raycast_pos

func _ready():
	pass

func _process(_delta):
	if raycast().has("position"):
		location = raycast().position
		emit_signal("raycast_pos", location)

func _input(_event):
	if Input.is_action_just_pressed("click"):
		if raycast().has("collider"):
			var collider = raycast().collider
			if collider.is_in_group("burger"):
				collider.is_dragging = true

# Raycaster
func raycast():
	var spaceState = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var camera = $Camera3D
	
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 200
	
	var intersect = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	intersect.collide_with_areas = true
	var ray = spaceState.intersect_ray(intersect)
	
#	var test = get_world_3d().direct_space_state.intersect_ray(PhysicsRayQueryParameters3D.create(camera.project_ray_origin(mousePos), camera.project_ray_origin(mousePos) + camera.project_ray_normal(mousePos) * 200))
	
	return ray
