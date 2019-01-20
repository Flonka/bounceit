extends KinematicBody2D

# Select which axis the paddle is locked to.
enum AxisUpdate {X,Y}
export(AxisUpdate) var axis_lock = AxisUpdate.X

var axis_vec : Vector2

const SPEED : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	match axis_lock:
		AxisUpdate.X:
			axis_vec = Vector2(1,0)
		AxisUpdate.Y:
			axis_vec = Vector2(0,1)
	axis_vec *= SPEED


func _physics_process(delta :float) -> void:
	var dir : Vector2 = get_global_mouse_position() - get_global_position()
	move_and_slide(dir * axis_vec)



