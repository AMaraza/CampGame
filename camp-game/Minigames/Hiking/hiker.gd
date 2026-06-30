extends Node2D

var selected = false
var mouse_offset = Vector2(0, 0)
var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected and !game_over:
		followMouse()
		
func followMouse():
	position = get_global_mouse_position() + mouse_offset

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset = position - get_global_mouse_position()
			selected = true
		else:
			selected = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = get_parent()
	if area.is_in_group("hiking_goal"):
		print("goal")
		game_over = true
		parent.emit_signal("goal_complete")
	elif area.is_in_group("forest"):
		print("failed")
		game_over = true
		parent.emit_signal("goal_failed")
