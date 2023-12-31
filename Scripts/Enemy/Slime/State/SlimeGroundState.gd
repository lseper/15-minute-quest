class_name SlimeGroundState extends State

@export var slime_death_state: State
@export var movement_animation: String
@export var ground_node: String
@export var damageable_node: Damageable

func on_enter():
	playback.travel(ground_node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if damageable_node.health <= 0:
		next_state = slime_death_state
