extends Node2D

signal goal_complete
signal goal_failed

var game_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var game_parent = get_parent() as GameManager
	print(game_parent.timer.time_left)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
