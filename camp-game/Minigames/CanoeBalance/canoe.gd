extends Node2D

var angular_velocity := 0.0

var input_power := 9
var damping := 0.985
var max_velocity := 5.0
var tilt_force := 6.0

var danger_angle := deg_to_rad(45)

var game_over := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = deg_to_rad(randf_range(-15, 15))
	
	if rotation < 0:
		angular_velocity = -1.5
	else:
		angular_velocity = 1.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if get_global_mouse_position().x < global_position.x:
			angular_velocity -= input_power * delta
		else:
			angular_velocity += input_power * delta
			
	angular_velocity += rotation * tilt_force * delta
	angular_velocity *= damping
	angular_velocity = clamp(angular_velocity, -max_velocity, max_velocity)
	
	rotation += angular_velocity * delta
	
	if abs(rotation) >= danger_angle:
		game_over = true
		print("FAIL")
		
	if game_over:
		if rotation < 0:
			rotation = move_toward(rotation, -PI, 6 * delta)
		else:
			rotation = move_toward(rotation, PI, 6 * delta)
