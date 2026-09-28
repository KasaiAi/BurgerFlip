extends Node3D

var show_pos = 2
var hide_pos = 2.4
#var patties = 3

#func _ready():
	# Spawn initial patties
	#for i in 3:
		#spawn_patty()

func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		position.z = show_pos
	elif Input.is_action_just_released("ui_accept"):
		position.z = hide_pos

func _on_spawn_patty_timeout():
	#patties += 1
	if get_children().size() < 3:
		spawn_patty()
	else:
		$SpawnPatty.paused = true

#func patty_count(value:int):
	#patties += value
	#print(patties)

func spawn_patty():
	var new_patty = load("res://Objects/borgar.tscn").instantiate()
	#new_patty.patty_update.connect(patty_count)
	#new_patty.position = next_vacant_spot()
	add_child(new_patty)

# restart tray timer when burger is removed from tray
# cooking timer
