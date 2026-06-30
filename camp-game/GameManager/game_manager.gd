extends Node2D
class_name GameManager

@export var game_time_bar: ProgressBar
@export var timer: Timer

@export var complete_text: Label
@export var fail_text: Label

var task_complete = false

const DRAG_MINIGAME_SCENE = preload("res://Minigames/FireBuilding/drag_test.tscn")
const ARCHERY_MINIGAME_SCENE = preload("res://Minigames/Archery/archery_game.tscn")
const FLAG_MINIGAME_SCENE = preload("res://Minigames/CaptureTheFlag/flag_game.tscn")
const ROCK_MINIGAME_SCENE = preload("res://Minigames/RockSkipping/rock_game.tscn")
const CANOE_MINIGAME_SCENE = preload("res://Minigames/CanoeBalance/canoe_game.tscn")
const HIKING_MINIGAME_SCENE = preload("res://Minigames/Hiking/hiking_game.tscn")

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
	#var random_int = randi_range(1, 6)
	var random_int = 5
	if random_int == 1:
		spawn_game(DRAG_MINIGAME_SCENE)
	elif random_int == 2:
		spawn_game(ARCHERY_MINIGAME_SCENE)
	elif random_int == 3:
		spawn_game(ROCK_MINIGAME_SCENE)
	elif random_int == 4:
		spawn_game(CANOE_MINIGAME_SCENE)
	elif random_int == 5:
		spawn_game(HIKING_MINIGAME_SCENE)
	else:
		spawn_game(FLAG_MINIGAME_SCENE)
	
	
func spawn_game(game_scene):
		var game_instance = game_scene.instantiate()
		game_instance.goal_complete.connect(_goal_complete)
		game_instance.goal_failed.connect(_goal_failed)
		add_child(game_instance)
		move_child(game_instance, 0)
