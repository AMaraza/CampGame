extends Node2D

var game_ended = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and !game_ended:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var tween := create_tween()
			tween.tween_property(self, "position", Vector2(position.x, position.y - 128), 0.2)



func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = get_parent()
	if area.is_in_group("flag_enemy"):
		if parent and parent.has_signal("goal_failed"):
			parent.goal_failed.emit()
			game_ended = true
	elif area.is_in_group("flag"):
		if parent and parent.has_signal("goal_complete"):
			parent.goal_complete.emit()
			game_ended = true
