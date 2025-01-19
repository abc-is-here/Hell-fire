extends Node2D

@onready var score: Label = $score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = str("Your final score: ", Global.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	Global.score = 0
	Global.playerHealth = 10
