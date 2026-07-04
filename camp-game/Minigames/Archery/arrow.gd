extends Node2D

var arrow_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += arrow_speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = get_parent()
	if area.is_in_group("Barrier"):
		if parent and parent.has_signal("goal_failed"):
			parent.goal_failed.emit()
			queue_free()
	else:
		if parent and parent.has_signal("goal_complete"):
			parent.goal_complete.emit()
			queue_free()
