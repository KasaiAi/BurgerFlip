extends CharacterBody3D

# node references
var world:Node3D = Global.world
var tray:Node3D

# raycast variables
var mouse_pos:Vector2
var is_dragging := false


var cooking := false
var finished := false

enum State {DRAGGING, COOKING, DONE}

func _ready() -> void:
	# Pegue uma referência decente à raiz da cena ao invés dessa bagaça!!
	world = get_parent().get_parent()
	tray = get_parent()
	world.connect("raycast_pos", _on_raycast_pos)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not is_dragging:
		velocity += get_gravity() * delta
	
	move_and_slide()
	
	# Retorna hambúrguer à bandeja
	## Mover checagem de retorno para script da bandeja
	if get_parent() != tray and not is_dragging:
		for index in get_slide_collision_count():
			var body := get_slide_collision(index).get_collider()
			if body == tray:
				reparent(tray)
				#emit_signal("patty_update", 1)
	
	# Checa se tá cozinhando ou não
	# BUG: o sinal às vezes é duplicado
	for index in get_slide_collision_count():
		var body := get_slide_collision(index).get_collider()
		if body.is_in_group("hot") and cooking == false:
			cooking = true
			#print(cooking)
			if not finished and $CookingTimer.is_stopped():
				$CookingTimer.start()
			else:
				$CookingTimer.paused = false
	# Para de cozinhar
	if is_dragging and cooking == true:
		cooking = false
		#print(cooking)
		$CookingTimer.paused = true
	
	if cooking:
		print($CookingTimer.time_left)

func _on_raycast_pos(location) -> void:
	if is_dragging:
		$Collider.disabled = true
		global_position = location
		position.y += .3

func _input(_event: InputEvent) -> void:
	if is_dragging and Input.is_action_just_released("click"):
		is_dragging = false
		$Collider.disabled = false


func _on_cooking_timeout() -> void:
	finished = true
	$Mesh.set_surface_override_material(0, load("res://Assets/Materials/cookedmeat.tres"))
	#var material = $Mesh.get_surface_override_material(0)
	#print(material)
	#material.albedo_color = Color(0.498, 0.192, 0.0, 1.0)
