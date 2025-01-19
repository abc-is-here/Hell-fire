extends CharacterBody2D

@onready var player = get_node("../../player")
var isAlive: bool = true
var speed: int = 20
var health: int = 5
@onready var sprite = get_node("Sprite2D")
@onready var healthBar: ProgressBar = $ProgressBar
@onready var anim_play: AnimatedSprite2D = $AnimPlay
@onready var bullet_pool: Node = get_node("bullets")

func _ready() -> void:
	healthBar.max_value = health

func _physics_process(delta: float) -> void:
	if isAlive:
		healthBar.value = health
		var direction: Vector2 = (player.global_position - self.global_position).normalized()
		self.velocity = speed*direction
		
		if direction.x<0:
			sprite.flip_h = false
			get_node("Marker2D").position = Vector2(-10, -11)
		else:
			get_node("Marker2D").position = Vector2(10, -11)
			sprite.flip_h = true
		anim_play.hide()
		sprite.show()
		healthBar.show()
		move_and_slide()
	else:
		anim_play.show()
		sprite.hide()
		healthBar.hide()
		get_node("CollisionShape2D").disabled = true

func reset_mob(body: Node) -> void:
	if health > 1:
		health-=1
	else:
		isAlive = false
		health = 5
		anim_play.play("death")
		await anim_play.animation_finished
		get_parent().reset_mob(body)
		Global.score+=1

func shoot_bullets() -> void:
	if self.visible:
		var tempBullet: Node = bullet_pool.get_bullet()
		var direction: Vector2 = (player.global_position - self.global_position).normalized()
		tempBullet.velocity = direction*100
		tempBullet.global_position = get_node("Marker2D").global_position
		tempBullet.show()
		$AudioStreamPlayer2D.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if visible and body.visible:
			Global.playerHealth-=1


func _on_shoot_timer_timeout() -> void:
	shoot_bullets()
