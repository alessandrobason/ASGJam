extends RigidBody2D

signal free_proj
signal collected

func _exit_tree():
	emit_signal("free_proj")

func _on_Droplet_body_entered(body):
	if body is KinematicBody2D and body.collision_layer == 4:
		body.make_liquid()
		emit_signal("collected")
		queue_free()
	else:
		print(body.collision_layer)
