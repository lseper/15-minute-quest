class_name HealthBar extends Node2D

@onready var health_bar := $TextureProgressBar

func set_health(change: int):
	health_bar.value = health_bar.value + change
	print(health_bar.value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
