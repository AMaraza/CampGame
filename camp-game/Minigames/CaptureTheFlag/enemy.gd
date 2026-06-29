extends Node2D

var speed = 5
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.x >= get_window().size.x - 128 or position.x <= 0 + 128:
		direction *= -1
	position.x += speed * direction
