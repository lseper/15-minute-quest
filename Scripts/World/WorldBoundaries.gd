class_name WorldBoundary extends Node2D

@onready var left_boundary = $LeftBoundary
@onready var right_boundary = $RightBoundary
@onready var bottom_boundary = $Floor
@onready var top_boundary = $TopBoundary

# Called when the node enters the scene tree for the first time.
func _ready():
	print(bottom_boundary.name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
