extends KinematicBody2D

# Select which axis the paddle is locked to.
enum AxisUpdate {X,Y}
export(AxisUpdate) var axis_lock = AxisUpdate.X


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	print(axis_lock)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _physics_process(delta: float) -> void:
	get_input()

func get_input() -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	match axis_lock:
		AxisUpdate.X:
			position.x = mouse_pos.x
		AxisUpdate.Y:
			position.y = mouse_pos.y



