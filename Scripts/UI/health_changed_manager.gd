extends Control

# is of type PackedScene as it is a scene
@export var health_changed_label : PackedScene
@export var damage_color: Color = Color.DARK_RED
@export var heal_color: Color = Color.DARK_GREEN

# Called when the node enters the scene tree for the first time.
func _ready():
# do the following callback when this signal happens
	SignalBus.connect("on_health_changed", on_signal_health_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_signal_health_changed(node: Node, amount_changed: int):
# creates an instance of the scene
	var label_instance : Label = health_changed_label.instantiate()
# actually adds it in the tree
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)
	if amount_changed > 0:
		label_instance.modulate = heal_color
	else:
		label_instance.modulate = damage_color
