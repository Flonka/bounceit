extends RigidBody2D

enum AxisUpdate {X,Y,XY}
export(AxisUpdate) var axis_lock = AxisUpdate.XY

var _axis_vector: Vector2

func _ready() -> void:
	match axis_lock:
		AxisUpdate.X:
			_axis_vector = Vector2(1,0)
		AxisUpdate.Y:
			_axis_vector = Vector2(0,1)
		AxisUpdate.XY:
			_axis_vector = Vector2(1,1)

func _physics_process(delta: float) -> void:
	if mode == RigidBody2D.MODE_KINEMATIC:
		set_global_position(get_global_mouse_position() * _axis_vector)


