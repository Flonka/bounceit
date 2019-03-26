extends KinematicBody2D

class_name Ball

var velocity_multiplier : float = 1.005

var _velocity : Vector2

func _ready() -> void:
	pass

#warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	# https://stackoverflow.com/questions/41210110/curved-trajectory-for-a-2d-game-in-java
	var ci : = move_and_collide(_velocity)
	if ci:
		var o : = ci.get_collider() as Paddle
		if o:
			#print("collider vel " + str(ci.get_collider_velocity()))
			o.ball_hit(ci, _velocity)
			_velocity *= velocity_multiplier

		_velocity = _velocity.bounce(ci.normal)




