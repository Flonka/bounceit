extends KinematicBody2D

class_name Ball

export(float) var init_velocity : float = 0.0

var _velocity : Vector2

const VELOCITY_MULTIPLIER : float = 1.005

func _ready() -> void:
	_velocity = Vector2(randf(), randf()).normalized() * init_velocity

#warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	# https://stackoverflow.com/questions/41210110/curved-trajectory-for-a-2d-game-in-java
	var ci : = move_and_collide(_velocity)
	if ci:
		var o : = ci.get_collider() as Paddle
		if o:
			print("paddle collision")
			o.ball_hit(ci, _velocity)
			print(ci.get_collider_velocity())
			_velocity *= VELOCITY_MULTIPLIER

		_velocity = _velocity.bounce(ci.normal)




