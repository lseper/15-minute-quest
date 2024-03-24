class_name LabelAndNumber extends NinePatchRect

@export var label_text : String
@export var label_starting_number : int
@export var label_color : Color = Color(1.0, 0.0, 0.0, 1.0)

@export var label_theme : Theme = load("res://Theme/default_theme.tres")

@onready var number = $Container/Number
@onready var label = $Container/Text

func set_label(value: String):
	label.text = value
	label.theme = label_theme
	label.add_theme_color_override("font_color", label_color)

func set_number(value: int):
	number.text = str(value)
	
func _ready():
	set_label(label_text)
	set_number(label_starting_number)
