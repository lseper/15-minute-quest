class_name Counter extends NinePatchRect

@onready var counter_display := $Label

func set_count(value: int):
	counter_display.text = str(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
