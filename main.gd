extends Node


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	var s := get_viewport().get_size()
	print(str(s))

	var paddle_scene := preload("res://scenes/rbpaddle/RbKinematidPaddle.tscn")

	var padding := 200

	var top_paddle : Paddle = paddle_scene.instance()
	top_paddle.set_axis_lock(Paddle.AxisUpdate.X)
	top_paddle.set_global_position(Vector2(0, padding))
	#self.add_child(top_paddle)

	var bottom_paddle := paddle_scene.instance()
	bottom_paddle.set_axis_lock(Paddle.AxisUpdate.X)
	bottom_paddle.set_position(Vector2(0, s.y - padding))
	#self.add_child(bottom_paddle)

	var right_paddle := paddle_scene.instance()
	right_paddle.set_axis_lock(Paddle.AxisUpdate.Y)
	right_paddle.set_position(Vector2(s.x - padding, 0))
	#self.add_child(right_paddle)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()