extends Node2D

var mob_scene: PackedScene = preload("res://cyclops_mob.tscn")
var pool_size: int = 10
var mob_pool: Array = []
@onready var timer = get_node("Timer")

func _ready() -> void:
	for i in range(pool_size):
		var tempMob: Node = mob_scene.instantiate()
		tempMob.hide()
		mob_pool.append(tempMob)
		add_child(tempMob)

func get_mob() -> Node:
	for mob in mob_pool:
		if not mob.visible:
			return mob
	
	var new_mob: Node = mob_scene.instantiate()
	new_mob.hide()
	mob_pool.append(new_mob)
	add_child(new_mob)
	return new_mob

func reset_mob(mob: Node) -> void:
	mob.global_position = Vector2(-10000, -10000)
	mob.isAlive = false
	mob.call_deferred("hide")
	mob.get_node("CollisionShape2D").call_deferred("set_disabled", false)


func _on_timer_timeout() -> void:
	var tempMob: Node = get_mob()
	var rand_x: int = randi_range(-50, 50)
	var rand_y: int = randi_range(-50, 50)
	tempMob.global_position = self.global_position + Vector2(rand_x, rand_y)
	tempMob.show()
