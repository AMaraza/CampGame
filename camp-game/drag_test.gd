extends Node2D

@export var items: Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for item in items:
		var random_x = randf_range(64, get_window().size.x - 64)
		var random_y = randf_range(64, get_window().size.y/2)
		item.position.x = random_x
		item.position.y = random_y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
