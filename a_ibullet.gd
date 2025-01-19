extends CharacterBody2D

func _process(delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if visible and body.visible:
			Global.playerHealth -= 1
			get_parent().reset_bullet(self)
