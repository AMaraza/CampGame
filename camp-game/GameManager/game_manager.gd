extends Node2D

@export var game_time_bar: ProgressBar
@export var timer: Timer

@export var complete_text: Label
@export var fail_text: Label

var task_complete = false

const DRAG_MINIGAME_SCENE = preload("res://Minigames/FireBuilding/drag_test.tscn")
const ARCHERY_MINIGAME_SCENE = preload("res://Minigames/Archery/archery_game.tscn")

#Comment to test gh

func _ready() -> void:
	randomize()
	timer.start()
	game_time_bar.value = 100
	complete_text.visible = false
	fail_text.visible = false
	spawn_minigame()


	
func _process(delta: float) -> void:
	if game_time_bar.value > 0:
		game_time_bar.value = (timer.time_left/timer.wait_time)*100
	elif game_time_bar.value <= 0 and !task_complete:
		fail_text.visible = true
	elif game_time_bar.value <=0 and task_complete:
		complete_text.visible = true
		
		
func _goal_complete():
	task_complete = true
	timer.stop()
	game_time_bar.value = 0
	
func _goal_failed():
	task_complete = false
	timer.stop()
	game_time_bar.value = 0
	
func spawn_minigame():
	var random_int = randi_range(1, 2)
	if random_int == 1:
		var game_instance = DRAG_MINIGAME_SCENE.instantiate()
		game_instance.goal_complete.connect(_goal_complete)
		game_instance.goal_failed.connect(_goal_failed)
		add_child(game_instance)
	else:
		var game_instance = ARCHERY_MINIGAME_SCENE.instantiate()
		game_instance.goal_complete.connect(_goal_complete)
		game_instance.goal_failed.connect(_goal_failed)
		add_child(game_instance)
	
