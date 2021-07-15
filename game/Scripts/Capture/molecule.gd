extends KinematicBody2D

const upward_velocity := 100.0

func _physics_process(_delta):
	var ignore = move_and_slide(Vector2(0.0, -upward_velocity))
