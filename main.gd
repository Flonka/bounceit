extends Node


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	_add_paddles()


func _add_paddles() -> void:
	var s := get_viewport().get_size()

	var paddle_scene := preload("res://scenes/rbpaddle/RbKinematidPaddle.tscn")

	var padding := 50

	var top_paddle : Paddle = paddle_scene.instance()
	top_paddle.set_axis_lock(Paddle.AxisUpdate.X)
	top_paddle.set_position(Vector2(0, padding))
	self.add_child(top_paddle)

	var bottom_paddle := paddle_scene.instance()
	bottom_paddle.set_axis_lock(Paddle.AxisUpdate.X)
	bottom_paddle.set_position(Vector2(0, s.y - padding))
	bottom_paddle.set_rotation_degrees(180)
	self.add_child(bottom_paddle)

	var right_paddle := paddle_scene.instance()
	right_paddle.set_axis_lock(Paddle.AxisUpdate.Y)
	right_paddle.set_rotation_degrees(90)
	right_paddle.set_position(Vector2(s.x - padding, 0))
	self.add_child(right_paddle)

	var left_paddle := paddle_scene.instance()
	left_paddle.set_axis_lock(Paddle.AxisUpdate.Y)
	left_paddle.set_position(Vector2(padding, 0))
	left_paddle.set_rotation_degrees(-90)
	self.add_child(left_paddle)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()