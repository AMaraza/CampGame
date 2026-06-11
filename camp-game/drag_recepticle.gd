extends Node2D

var next_item = 1
var goal_complete = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	var colliding_root = area.get_parent()
	
	if "item_id" in colliding_root:
		var id = colliding_root.item_id
		if id == next_item:
			print("correct")
			next_item += 1
		else:
			_on_timer_timeout()
			
		if next_item == 4:
			goal_complete = true
			_on_timer_timeout()


func _on_timer_timeout() -> void:
	if goal_complete:
		print("task completed")
	else:
		print("task failed")
