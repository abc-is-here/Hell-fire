extends Node

var bullet_scene: PackedScene = preload("res://bullet.tscn")
var pool_size: int = 10
var bullet_pool: Array = []

func _ready() -> void:
	for i in range(pool_size):
		var tempBullet: Node = bullet_scene.instantiate()
		tempBullet.hide()
		bullet_pool.append(tempBullet)
		add_child(tempBullet)

func get_bullet() -> Node:
	for bullet in bullet_pool:
		if not bullet.visible:
			return bullet
	
	var new_bullet: Node = bullet_scene.instantiate()
	new_bullet.hide()
	bullet_pool.append(new_bullet)
	add_child(new_bullet)
	return new_bullet

func reset_bullet(bullet: Node) -> void:
	bullet.position = Vector2(-10000, -10000)
	bullet.hide()
