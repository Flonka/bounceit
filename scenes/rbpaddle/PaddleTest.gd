extends Node

var p

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

func _ready() -> void:
		var paddle_scene := preload("res://scenes/rbpaddle/RbKinematidPaddle.tscn")
		p = paddle_scene.instance()

		p.set_axis_lock(Paddle.AxisUpdate.XY)
		p.set_position(Vector2(50, 50))
		p.set_rotation(PI/4)

		self.add_child(p)

func _process(delta: float) -> void:
	p.rotate(10 * delta)
