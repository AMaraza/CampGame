extends Node2D
class_name GameManager

# GameUI
@onready var game_ui_parent: Node2D = $GameUI_Parent
@onready var game_time_bar: ProgressBar = $GameUI_Parent/GameTime
@onready var timer: Timer = $GameUI_Parent/Timer
@onready var complete_text: Label = $GameUI_Parent/CompleteText
@onready var fail_text: Label = $GameUI_Parent/FailText

# IntermissionUI
@onready var intermission_ui_parent: Node2D = $IntermissionUI_Parent
@onready var lives_text: Label = $IntermissionUI_Parent/LivesText
@onready var intermission_timer: Timer = $IntermissionUI_Parent/Intermission_Timer
@export var hearts: Array[Sprite2D] = []

# Game Variables
var is_intermission = true
var is_spawned = false
var lives = 3
var task_complete = false
var current_game

# Minigame Scenes
const DRAG_MINIGAME_SCENE = preload("res://Minigames/FireBuilding/drag_test.tscn")
const ARCHERY_MINIGAME_SCENE = preload("res://Minigames/Archery/archery_game.tscn")
const FLAG_MINIGAME_SCENE = preload("res://Minigames/CaptureTheFlag/flag_game.tscn")
const ROCK_MINIGAME_SCENE = preload("res://Minigames/RockSkipping/rock_game.tscn")
const CANOE_MINIGAME_SCENE = preload("res://Minigames/CanoeBalance/canoe_game.tscn")
const HIKING_MINIGAME_SCENE = preload("res://Minigames/Hiking/hiking_game.tscn")
const SIMON_MINIGAME_SCENE = preload("res://Minigames/Simon/simon_game.tscn")


func _ready() -> void:
	randomize()
	intermission_timer.start()
	
func _process(delta: float) -> void:
	if is_intermission and !is_spawned:
		hide_game_ui()
		show_intermission_ui()
		is_spawned = true
	elif !is_intermission and !is_spawned:
		hide_intermission_ui()
		reset_game_bar()
		show_game_ui()
		is_spawned = true
		
	if !is_intermission:
		check_bar_state()
		

# Show & Hide UI Elements
func display_lives():
	for heart in hearts:
		heart.visible = false
		
	for i in lives:
		hearts[i].visible = true
		
func hide_intermission_ui():
	intermission_ui_parent.visible = false
	
func show_intermission_ui():
	intermission_ui_parent.visible = true
	display_lives()
	
func hide_game_ui():
	game_ui_parent.visible = false
	
func show_game_ui():
	game_ui_parent.visible = true

# Timer Events
func _on_timer_timeout() -> void:
	intermission_timer.start()
	is_spawned = false
	is_intermission = true
	
func _on_intermission_timer_timeout() -> void:
	timer.start()
	is_spawned = false
	is_intermission = false
	choose_game()
	
#Game Handling
func reset_game_bar():
	game_time_bar.value = 100

func check_bar_state():
	if game_time_bar.value > 0:
		game_time_bar.value = (timer.time_left/timer.wait_time)*100
	elif game_time_bar.value <= 0 and !task_complete:
		pass
	elif game_time_bar.value <= 0 and task_complete:
		pass
		
func choose_game():
	var random_int = randi_range(1, 6)
	#var random_int = 3
	if random_int == 1:
		spawn_game(DRAG_MINIGAME_SCENE)
	elif random_int == 2:
		spawn_game(ARCHERY_MINIGAME_SCENE)
	elif random_int == 3:
		spawn_game(ROCK_MINIGAME_SCENE)
	elif random_int == 4:
		spawn_game(FLAG_MINIGAME_SCENE)
	elif random_int == 5:
		spawn_game(HIKING_MINIGAME_SCENE)
	elif random_int == 6:
		spawn_game(SIMON_MINIGAME_SCENE)
	else:
		print("Out of range")
		
func spawn_game(game_scene):
	var game_instance = game_scene.instantiate()
	game_instance.goal_complete.connect(_goal_complete)
	game_instance.goal_failed.connect(_goal_failed)
	current_game = game_instance
	game_ui_parent.add_child(game_instance)
	game_ui_parent.move_child(game_instance, 0)
	
func despawn_game():
	current_game.queue_free()
	
func _goal_complete():
	task_complete = true
	timer.emit_signal("timeout")
	timer.stop()
	game_time_bar.value = 0
	despawn_game()
	
func _goal_failed():
	task_complete = false
	timer.emit_signal("timeout")
	timer.stop()
	game_time_bar.value = 0
	despawn_game()
	lives -= 1
	
