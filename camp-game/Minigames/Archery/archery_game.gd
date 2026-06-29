extends Node2D

@onready var target: Node2D = $Target
@onready var arrow_sprite: Sprite2D = $Sprite2D

var ARROW_SCENE = preload("uid://bl3u2k2horb3s")

signal goal_complete
signal goal_failed

var shot_arrow = false
var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var random_y = randf_range(64, get_window().size.y - 64)
	target.position.y = random_y
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	arrow_sprite.position.y += 300 * direction * delta
	
	if arrow_sprite.position.y < 0 or arrow_sprite.position.y > get_window().size.y:
		direction *= -1
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !shot_arrow:
			var arrow_instance = ARROW_SCENE.instantiate()
			arrow_instance.global_position = arrow_sprite.global_position
			add_child(arrow_instance)
			shot_arrow = true
