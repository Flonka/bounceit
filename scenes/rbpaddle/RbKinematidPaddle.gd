extends RigidBody2D

class_name Paddle

enum AxisUpdate {X,Y,XY}

onready var timer : Timer = $RigidTimer
onready var position_tween := $PositionTween
onready var rotation_tween := $RotationTween
onready var original_rotation := self.get_rotation()
onready var original_position := self.get_global_position()

const position_tween_duration := 1.1
const rotation_tween_duration := 2.0
const time_in_rigid_mode := 1.5

var _axis_vector: Vector2

# Workaround needed for bug causing a need for a physics-frame between
# switching modes.
var _hit_i : int = 0


func _ready() -> void:

	set_gravity_scale(0)

	timer.set_one_shot(true)
	timer.set_wait_time(time_in_rigid_mode)
	if _axis_vector == Vector2.ZERO:
		set_axis_lock(AxisUpdate.XY)

func set_axis_lock(lock : int) -> void:
	match lock:
		AxisUpdate.X:
			_axis_vector = Vector2(1,0)
		AxisUpdate.Y:
			_axis_vector = Vector2(0,1)
		AxisUpdate.XY:
			_axis_vector = Vector2(1,1)

#warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	if mode == RigidBody2D.MODE_KINEMATIC:
		if not position_tween.is_active():
			var relative_mouse_pos := get_local_mouse_position().rotated(self.get_rotation())
			translate(relative_mouse_pos * _axis_vector)
	elif mode == RigidBody2D.MODE_RIGID:
		_apply_impulses()

func _apply_impulses() -> void:
	"""Contains ugly workaround for 'physics-frame' bug"""

	if _hit_i > 0:
		_hit_i -= 1
	elif _hit_i == 0:
		var i := (Vector2.UP * 100).rotated(get_rotation())
		var pos := Vector2(100,0).rotated(get_rotation())
		apply_impulse(pos, i)
		_hit_i -= 1


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if self.mode == RigidBody2D.MODE_KINEMATIC:
		state.set_transform(get_global_transform())

func ball_hit(c: KinematicCollision2D, ball_velocity : Vector2) -> void:

	if self.mode != RigidBody2D.MODE_RIGID:
		self.set_mode(RigidBody2D.MODE_RIGID)
		var offset_pos := c.get_position() - get_global_position()
		offset_pos = offset_pos.rotated(get_rotation())
		var i := (Vector2.UP * 100)
		apply_impulse(Vector2(100,0), i)
		if timer.is_stopped():
			timer.start()

func _on_RigidTimer_timeout() -> void:
	self.set_mode(RigidBody2D.MODE_KINEMATIC)
	self._add_tweening()

func _add_tweening() -> void:
	position_tween.follow_method(
		self, "set_global_position", self.get_global_position(),
		self, "_get_tween_target", self.position_tween_duration,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)

	rotation_tween.interpolate_property(
		self, "rotation", self.get_rotation(),
		self.original_rotation, self.rotation_tween_duration,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)

	position_tween.start()
	rotation_tween.start()

func _get_tween_target() -> Vector2:
	return original_position + get_global_mouse_position() * _axis_vector

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	pass
	#print_debug("tween "+ str(object)  + key + " complete")
