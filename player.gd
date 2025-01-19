extends CharacterBody2D

var speed: int = 75
var direction: Vector2 = Vector2(0, 1)
@onready var bullet_pool = get_node("bullet")

func _physics_process(delta: float) -> void:
	var input: Vector2 = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	
	if input.x > 0:
		get_node("Player").frame = 1
		get_node("Player").flip_h = false
		direction = input
	elif input.x < 0:
		get_node("Player").frame = 1
		get_node("Player").flip_h = true
		direction = input
	if input.y > 0:
		get_node("Player").frame = 0
		get_node("Player").flip_h = false
		direction = input
	elif input.y < 0:
		get_node("Player").frame = 2
		get_node("Player").flip_h = false
		direction = input
	
	get_node("spawn_point").position = direction*5
	if Input.is_action_just_pressed("shoot"):
		var tempBullet: Node = bullet_pool.get_bullet()
		tempBullet.velocity = direction*100
		tempBullet.global_position = get_node("spawn_point").global_position
		tempBullet.show()
		
	velocity = input*speed
	
	move_and_slide()
