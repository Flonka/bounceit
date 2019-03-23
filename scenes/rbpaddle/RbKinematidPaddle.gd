extends RigidBody2D

class_name Paddle

enum AxisUpdate {X,Y,XY}
export(AxisUpdate) var axis_lock = AxisUpdate.XY

var _axis_vector: Vector2

onready var timer : Timer = $RigidTimer
onready var tween : Tween = $Tween

func _ready() -> void:
	match axis_lock:
		AxisUpdate.X:
			_axis_vector = Vector2(1,0)
		AxisUpdate.Y:
			_axis_vector = Vector2(0,1)
		AxisUpdate.XY:
			_axis_vector = Vector2(1,1)

	timer.set_one_shot(true)
	timer.set_wait_time(1.5)

#warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	if mode == RigidBody2D.MODE_KINEMATIC and not tween.is_active():
		set_global_position(get_global_mouse_position() * _axis_vector)

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var xform : Transform2D = state.get_transform()
	xform.origin = get_global_position()
	state.set_transform(xform)

func ball_hit(collision_object: KinematicCollision2D, ball_velocity : Vector2) -> void:
	if self.mode != RigidBody2D.MODE_RIGID:
		self.set_mode(RigidBody2D.MODE_RIGID)

		if timer.is_stopped():
			timer.start()

func _on_RigidTimer_timeout() -> void:
	self.set_mode(RigidBody2D.MODE_KINEMATIC)



