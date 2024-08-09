extends Node3D

var motion = Vector3()
var show_pos = 2
var hide_pos = 2.4
var patties = 3

func _ready():
#	spawn initial patties
	pass

func _input(_event):
	if Input.is_action_pressed("ui_accept"):
		position.z = show_pos
	elif Input.is_action_just_released("ui_accept"):
		position.z = hide_pos

func _on_spawn_patty_timeout():
	patties += 1
