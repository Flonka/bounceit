extends KinematicBody2D

class_name Ball

export(float) var init_velocity : float = 0.0

var _velocity : Vector2

const VELOCITY_MULTIPLIER : float = 1.05

func _ready() -> void:
	_velocity = Vector2(randf(), randf()).normalized() * init_velocity

func _physics_process(delta: float) -> void:
	var ci : = move_and_collide(_velocity)
	if ci:
		_velocity = _velocity.bounce(ci.normal)
		_velocity *= VELOCITY_MULTIPLIER
		var o : = ci.get_collider() as RigidBody2D
		if o and o.get_mode() != RigidBody2D.MODE_RIGID:
			o.set_mode(RigidBody2D.MODE_RIGID)
			# Bug https://github.com/godotengine/godot/issues/25738
			o.set_sleeping(false)


