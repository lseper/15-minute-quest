class_name PositionDebugLabel extends Label

@onready var character := get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Position: (%.1f, %.1f)" % [character.position.x, character.position.y]
