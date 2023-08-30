class_name Counter extends NinePatchRect

@onready var counter_display := $Label

func set_count(value: int):
	counter_display.text = str(value)
