extends Node2D

@onready var strings_1: Node2D = $Strings
@onready var strings_2: Node2D = $Strings2
@onready var strings_3: Node2D = $Strings3
@onready var strings_4: Node2D = $Strings4

var sequence = []
var current_index = 0
var clicked_string = 0

signal goal_complete
signal goal_failed

var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for i in 5:
		var random_int = randi_range(1, 4)
		sequence.push_back(random_int)
		
	print(sequence)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_index == 5 and !game_over:
		goal_complete.emit()
		game_over = true


func _on_strings_string_clicked() -> void:
	clicked_string = 1
	check_string()

func _on_strings_2_string_clicked() -> void:
	clicked_string = 2
	check_string()

func _on_strings_3_string_clicked() -> void:
	clicked_string = 3
	check_string()

func _on_strings_4_string_clicked() -> void:
	clicked_string = 4
	check_string()
	
func check_string():
	if current_index < sequence.size() and clicked_string == sequence[current_index]:
		print("Correct String")
		current_index+= 1
	else:
		print("Wrong String")
		goal_failed.emit()
