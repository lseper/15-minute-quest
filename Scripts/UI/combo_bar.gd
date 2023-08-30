class_name ComboBar extends Node2D

@onready var combo_bar := $TextureProgressBar

func set_combo_bar_value(value: int):
	combo_bar.value = value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
