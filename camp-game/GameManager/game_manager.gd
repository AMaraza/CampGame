extends Node2D

@export var game_time_bar: ProgressBar
@export var timer: Timer

@export var complete_text: Label
@export var fail_text: Label

var task_complete = false

func _ready() -> void:
	timer.start()
	game_time_bar.value = 100
	complete_text.visible = false
	fail_text.visible = false
	
func _process(delta: float) -> void:
	if game_time_bar.value > 0:
		game_time_bar.value = (timer.time_left/timer.wait_time)*100
	elif game_time_bar.value <= 0 and !task_complete:
		fail_text.visible = true
	elif game_time_bar.value <=0 and task_complete:
		complete_text.visible = true
