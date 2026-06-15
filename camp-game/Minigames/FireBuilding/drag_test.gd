extends Node2D

@export var items: Array[Node2D] = []
signal goal_complete
signal goal_failed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	var item_locations: PackedVector2Array = []
	
	for item in items:
		var placed = false
		
		while !placed:
			var random_x = randf_range(64, get_window().size.x - 64)
			var random_y = randf_range(64, get_window().size.y / 2)
			
			var valid_position = true
			
			for location in item_locations:
				if location.distance_to(Vector2(random_x, random_y)) < 80:
					valid_position = false
					break
					
			if valid_position:
				item.position = Vector2(random_x, random_y)
				item_locations.append(item.position)
				placed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
