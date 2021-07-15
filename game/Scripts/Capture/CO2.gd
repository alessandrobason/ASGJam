extends KinematicBody2D

const upward_velocity := 100.0

var is_liquid := false

func _physics_process(_delta):
	var vel = Vector2(0.0, -upward_velocity)
	
	if is_liquid:
		vel.y *= -5.0
		
	var ignore = move_and_slide(vel)

func make_liquid():
	if not is_liquid:
		is_liquid = true
		collision_layer = 2
		collision_mask = 2
		$Sprite.modulate = Color(0.1, 0.5, 0.9, 0.3)
