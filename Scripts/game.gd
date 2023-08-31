class_name Game extends Node2D

@export var player: MainPlayer
@export var ui : UI
@export var item_manager: ItemManager

# Called when the node enters the scene tree for the first time.
func _ready():
#	check if this signal has already been connected (sort of a singleton)
	if not player.collected.is_connected(ui._on_collected):	
		player.collected.connect(ui._on_collected)
	if not player.damageable_node.on_hit.is_connected(ui._update_health_bar):
		player.damageable_node.on_hit.connect(ui._update_health_bar)
	if not player.special_state.combo_charge.is_connected(ui._update_combo_bar):
		player.special_state.combo_charge.connect(ui._update_combo_bar)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
