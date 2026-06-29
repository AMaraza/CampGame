extends Node2D
class_name Rock

var fall_speed = 3
var num_bounces = 0
var target_bounces = 5
var game_over = false
var on_time = false
@onready var water_line: Node2D = $"../WaterLine"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += fall_speed
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !game_over and on_time:
			var tween := create_tween()
			tween.tween_property(self, "position", Vector2(position.x, 128), 0.2)
			num_bounces += 1
			
			if num_bounces == target_bounces:
				var parent = get_parent()
				parent.emit_signal("goal_complete")
				game_over = true
		else:
			var parent = get_parent()
			if position.y > water_line.position.y:
				parent.emit_signal("goal_failed")


func _on_area_2d_area_entered(area: Area2D) -> void:
	on_time = true
	

func _on_area_2d_area_exited(area: Area2D) -> void:
	on_time = false
