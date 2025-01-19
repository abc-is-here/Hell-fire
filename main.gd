extends Node2D

var time_survived: int = 0

func _on_timer_timeout() -> void:
	time_survived+=1
