@tool
extends Node2D

var selected = false
var mouse_offset = Vector2(0, 0)

@export var item_id = 0
@export var character_sprite: Texture2D:
	set(value):
		character_sprite = value
		if is_node_ready():
			$Sprite2D.texture = value
			
func _ready() -> void:
	$Sprite2D.texture = character_sprite

func _process(delta):
	if selected:
		followMouse()
		
func followMouse():
	position = get_global_mouse_position() + mouse_offset

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset = position - get_global_mouse_position()
			selected = true
		else:
			selected = false
