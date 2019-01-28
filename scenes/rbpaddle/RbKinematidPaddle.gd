extends RigidBody2D
class_name RbPaddle

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if mode == RigidBody2D.MODE_KINEMATIC:
		set_global_position(get_global_mouse_position())


