extends RigidBody2D

class_name Paddle

enum AxisUpdate {X,Y,XY}
export(AxisUpdate) var axis_lock = AxisUpdate.XY

const position_tween_duration := 1.1
const rotation_tween_duration := 2

var _axis_vector: Vector2

onready var timer : Timer = $RigidTimer
onready var position_tween := $PositionTween
onready var rotation_tween := $RotationTween
onready var original_rotation := self.get_rotation()

func _ready() -> void:
	match axis_lock:
		AxisUpdate.X:
			_axis_vector = Vector2(1,0)
		AxisUpdate.Y:
			_axis_vector = Vector2(0,1)
		AxisUpdate.XY:
			_axis_vector = Vector2(1,1)

	timer.set_one_shot(true)
	timer.set_wait_time(0.7)

#warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	if mode == RigidBody2D.MODE_KINEMATIC and not position_tween.is_active():
		set_global_position(get_global_mouse_position() * _axis_vector)

func _integrate_forces(state: Physics2DDirectBodyState) -> void:

	if self.mode == RigidBody2D.MODE_KINEMATIC:
		var xform : Transform2D = state.get_transform().orthonormalized()
		xform.origin = get_global_position()
		xform.rotated(self.get_rotation())
		state.set_transform(xform)

func ball_hit(collision_object: KinematicCollision2D, ball_velocity : Vector2) -> void:
	if self.mode != RigidBody2D.MODE_RIGID:
		print("set to rigid")
		self.set_mode(RigidBody2D.MODE_RIGID)

		if timer.is_stopped():
			print_debug("start timer")
			timer.start()

func _on_RigidTimer_timeout() -> void:
	self.set_mode(RigidBody2D.MODE_KINEMATIC)
	self._add_tweening()

func _add_tweening() -> void:
	position_tween.follow_method(
		self, "set_global_position", self.get_global_position(),
		self, "get_global_mouse_position", self.position_tween_duration,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	rotation_tween.interpolate_property(
		self, "rotation", self.get_rotation(),
		self.original_rotation, self.rotation_tween_duration,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	position_tween.start()
	rotation_tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	print_debug("tween "+ str(object)  + key + " complete")
