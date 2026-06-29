extends Node2D

signal goal_complete
signal goal_failed

@onready var rock: Rock = $Rock
@onready var target_bounces_label: Label = $TargetBounces
@onready var current_bounces_label: Label = $CurrentBounces

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_bounces_label.text = "Target Bounces: " + str(rock.target_bounces)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_bounces_label.text = "# of Bounces: " + str(rock.num_bounces)
	
