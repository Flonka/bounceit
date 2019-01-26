extends KinematicBody2D

class_name Ball

var _velocity : Vector2

const VELOCITY_MULTIPLIER : float = 1.08
const INIT_VELOCITY : float = 5.0

func _ready() -> void:
	_velocity = Vector2(randf(), randf()).normalized() * INIT_VELOCITY

func _physics_process(delta: float) -> void:
	var ci : = move_and_collide(_velocity)
	if ci:
		_velocity = _velocity.bounce(ci.normal)
		_velocity *= VELOCITY_MULTIPLIER


