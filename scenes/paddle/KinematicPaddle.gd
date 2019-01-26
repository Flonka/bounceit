extends KinematicBody2D

class_name KinematicPaddle

# Select which axis the paddle is locked to.
enum AxisUpdate {X,Y,XY}
export(AxisUpdate) var axis_lock = AxisUpdate.X

var _axis_vector: Vector2

func _ready() -> void:

	match axis_lock:
		AxisUpdate.X:
			_axis_vector = Vector2(1,0)
		AxisUpdate.Y:
			_axis_vector = Vector2(0,1)
		AxisUpdate.XY:
			_axis_vector = Vector2(1,1)

func _physics_process(delta :float) -> void:
	var v : = get_global_mouse_position() - get_global_position()
	var collision_info : = move_and_collide(v * _axis_vector)
