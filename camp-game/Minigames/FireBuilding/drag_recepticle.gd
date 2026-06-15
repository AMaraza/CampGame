extends Node2D

var next_item = 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = get_parent()
	var colliding_root = area.get_parent()
	
	if "item_id" in colliding_root:
		var id = colliding_root.item_id
		if id == next_item:
			print("correct")
			next_item += 1
		else:
			if parent and parent.has_signal("goal_failed"):
				parent.goal_failed.emit()
			
		if next_item == 4:
			if parent and parent.has_signal("goal_complete"):
				parent.goal_complete.emit()


#func _on_timer_timeout() -> void:
	#if goal_complete:
		#print("task completed")
	#else:
		#print("task failed")
