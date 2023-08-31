class_name ProgressPercentageBar extends Node2D

@onready var progress_percentage_bar := $TextureProgressBar

func set_progress_by_change(change: int):
	progress_percentage_bar.value = progress_percentage_bar.value + change

func set_progress_by_percent(percent : float):
	progress_percentage_bar.value = clamp(percent * 100, 0, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
