class_name LabelAndNumber extends NinePatchRect

@onready var number := $Container/Number

func set_number(value: int):
	number.text = str(value)
