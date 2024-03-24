class_name Announcement extends Node2D

@export var text := "Announcement!"

@onready var label := $Text
@onready var timer := $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = text
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()
