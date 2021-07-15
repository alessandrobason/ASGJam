extends Area2D

func _on_playable_area_body_exited(body):
	print("body exiting: ", body)
	body.queue_free()
