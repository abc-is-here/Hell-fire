extends Area2D

func _on_body_entered(body):
	if body.name == "Snake":
		body.remove_last_segment()
		queue_free()
