extends RigidBody2D

class_name Paddle

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

#warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	if mode == RigidBody2D.MODE_KINEMATIC:
		set_global_position(get_global_mouse_position() * _axis_vector)

func ball_hit(collision_object: KinematicCollision2D, ball_velocity : Vector2) -> void:
	if self.mode != RigidBody2D.MODE_RIGID:
		self.mode = RigidBody2D.MODE_RIGID
		# Bug https://github.com/godotengine/godot/issues/25738
		self.sleeping = false
		self.apply_impulse(get_global_position() - collision_object.position, ball_velocity)
