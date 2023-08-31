class_name ComboBarActual extends ProgressPercentageBar

@onready var combo_number_label : Label = $ComboLabel/ComboNumber
@onready var multiplier_label : Label = $ComboMultiplier

const MAX_MULTIPLER := 5.0
var combo := 1
var multiplier := 1.0

func _set_multiplier():
	multiplier = clamp(1.0 + ((combo - 1) / 10.0), 1.0, MAX_MULTIPLER)

func _set_multiplier_text():
	multiplier_label.text = "x %.1f" % multiplier
	
func _set_combo_number_label():
	combo_number_label.text = str(combo - 1)

func set_combo(new_combo: int):
	combo = new_combo
	_set_multiplier()
	_set_multiplier_text()
	_set_combo_number_label()
	
func reset_combo():
	set_combo(1)

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_combo()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
