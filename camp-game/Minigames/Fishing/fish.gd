extends Node2D

var fish_speed = 500
var direction = 1
@export var sprite_2d: Sprite2D

var hooked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !hooked:
		if position.x > get_window().size.x - 128 or position.x < 128:
			direction *= -1
			sprite_2d.flip_h = !sprite_2d.flip_h
			
		position.x += fish_speed * direction * delta
	else:
		position.y = get_global_mouse_position().y
		
		if position.y < 150:
			var parent = get_parent()
			if parent and parent.has_signal("goal_complete"):
				parent.goal_complete.emit()
				print("Fished")
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("fish_hook"):
		hooked = true
