extends Node3D

var mouse_pos: Vector2
var is_dragging = false

func _ready():
	get_parent().get_parent().connect("raycast_pos", _on_raycast_pos)

func _on_raycast_pos(location):
	if is_dragging:
		$Collider.disabled = true
		global_position = location
		global_position.y += .2

func _input(_event):
	if is_dragging and Input.is_action_just_released("click"):
		global_position.y -= .2
		is_dragging = false
		$Collider.disabled = false
		print("Saiu")
