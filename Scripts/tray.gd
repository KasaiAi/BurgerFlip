extends Node3D

var motion = Vector3()
var spawnPatty = Timer.new()
var show_pos = 2
var hide_pos = 2.4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept"):
		position.z = show_pos
		
	else:
		position.z = hide_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

