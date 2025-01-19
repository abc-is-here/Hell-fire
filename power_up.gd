extends Area2D

@export var effect: String = "speed_boost"

func _on_body_entered(body):
	if body.name == "Player":
		if effect == "speed_boost":
			body.speed *= 1.5
		queue_free()
