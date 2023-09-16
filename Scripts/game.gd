class_name Game extends Node2D

@export var player: MainPlayer
@export var ui : UI
@export var item_manager: ItemManager

# SlimeSpawner
@export var slime_spawner: PackedScene
# Boss for level 10
@export var necromancer : PackedScene

@onready var floor = $WorldBoundaries/Floor

func _setup_slime_spawner():
	var slime_spawner_instance = slime_spawner.instantiate()
	slime_spawner_instance.player = player
	slime_spawner.item_manager = item_manager
	add_child(slime_spawner_instance)
	
# use for boss-fights 
func _disable_slime_spawner():
	var slime_spawner = $SlimeSpawner
	slime_spawner.process_mode = Node.PROCESS_MODE_DISABLED

# use to re-enable in boss-fights
func _enable_slime_spawner():
	var slime_spawner = $SlimeSpawner
	slime_spawner.process_mode = Node.PROCESS_MODE_INHERIT
	
func _setup_necromancer():
	var necromancer_instance = necromancer.instantiate()
	necromancer_instance.seeking = player
	necromancer_instance.ground = floor
	add_child(necromancer_instance)

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
