extends Node2D

@export var grid_size: int = 32
@export var move_speed: float = 3.0
@export var game_area: Rect2 = Rect2(Vector2(0, 0), Vector2(640, 480))

@onready var player = get_node("../player")
@onready var body_segments = $snake/BodySegments

var current_direction: Vector2 = Vector2.ZERO
var next_position: Vector2 = Vector2.ZERO
var segment_positions = []

func _ready():
	$snake.global_position = snap_to_grid($snake.global_position)
	next_position = $snake.global_position

func _process(delta):
	if player:
		var target_position = snap_to_grid(player.global_position)
		if $snake.global_position == next_position:
			current_direction = calculate_direction(target_position)
			next_position = $snake.global_position + current_direction * grid_size

		move_toward_next_position(delta)

		update_body_segments()

		if check_collision_with_player():
			respawn_player()
			grow_snake()

func snap_to_grid(position: Vector2) -> Vector2:
	return Vector2(
		round(position.x / grid_size) * grid_size,
		round(position.y / grid_size) * grid_size
	)

func calculate_direction(target: Vector2) -> Vector2:
	var direction = Vector2.ZERO
	if abs(target.x - $snake.global_position.x) > abs(target.y - $snake.global_position.y):
		direction.x = sign(target.x - $snake.global_position.x)
	else:
		direction.y = sign(target.y - $snake.global_position.y)
	return direction

func move_toward_next_position(delta):
	var step = move_speed * grid_size * delta
	$snake.global_position = $snake.global_position.move_toward(next_position, step)

func update_body_segments():
	segment_positions.insert(0, $snake.global_position)
	if segment_positions.size() > body_segments.get_child_count():
		segment_positions.pop_back()

	for i in body_segments.get_child_count():
		var segment = body_segments.get_child(i)
		segment.global_position = segment_positions[i]

func check_collision_with_player() -> bool:
	var head_position = $snake.global_position
	var player_position = player.global_position

	return head_position.distance_to(player_position) < grid_size

func respawn_player():
	var random_x = randi() % int(game_area.size.x / grid_size) * grid_size + game_area.position.x
	var random_y = randi() % int(game_area.size.y / grid_size) * grid_size + game_area.position.y
	player.global_position = Vector2(random_x, random_y)

func grow_snake():
	var new_segment = Sprite2D.new()
	new_segment.texture = preload("res://snake_segment.png")
	body_segments.add_child(new_segment)
