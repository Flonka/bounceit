extends Node

var p

func _ready() -> void:
		var paddle_scene := preload("res://scenes/rbpaddle/RbKinematidPaddle.tscn")
		p = paddle_scene.instance()
		p.set_axis_lock(Paddle.AxisUpdate.XY)
		p.set_position(Vector2(500, 150))
		p.set_rotation(PI/4)
		#p.set_mode(RigidBody2D.MODE_RIGID)

		self.add_child(p)

		var ball := preload("res://scenes/ball/Ball.tscn").instance()
		ball.set_global_position(Vector2(100, 100))
		add_child(ball)

func _process(delta: float) -> void:
	pass
	#p.rotate(10 * delta)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
		if event.pressed and event.scancode == KEY_1:
			p.set_mode(RigidBody2D.MODE_RIGID)
			p.set_gravity_scale(1)
			p.set_sleeping(false)
			#p.apply_central_impulse(Vector2.ZERO)
			prints(p.get_applied_force(), p.get_applied_torque(), p.get_linear_velocity(), p.angular_velocity)
			var i := (Vector2.UP * 100).rotated(p.get_rotation())
			var pos := Vector2(100,0).rotated(p.get_rotation())
			#prints(pos, i)
			#p.apply_impulse(pos, i)
			#p.apply_torque_impulse(40000)
			p.hit_i = 1

		if event.pressed and event.scancode == KEY_2:
			p.set_mode(RigidBody2D.MODE_KINEMATIC)
			p.set_gravity_scale(0)
		if event.pressed and event.scancode == KEY_SPACE:
			p.set_mode(RigidBody2D.MODE_KINEMATIC)
			p.set_mode(RigidBody2D.MODE_RIGID)
			prints(p.get_applied_force(), p.get_applied_torque(), p.get_linear_velocity(), p.angular_velocity)
			var i := (Vector2.UP * 100).rotated(p.get_rotation())
			var pos := Vector2(100,0).rotated(p.get_rotation())
			prints(pos, i)
			p.apply_impulse(pos, i)
