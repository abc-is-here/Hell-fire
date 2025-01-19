extends CharacterBody2D

func _process(delta: float) -> void:
	self.rotation+=1
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("mob"):
		if body.isAlive and body.visible and self.visible:
			body.reset_mob(body)
			get_parent().reset_bullet(self)
