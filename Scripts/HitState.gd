class_name HitState extends State

@export var damageable_node : Damageable
@export var death_state: State

# Called when the node enters the scene tree for the first time.
func _ready():
	damageable_node.connect("on_hit", on_damageable_hit)

func on_damageable_hit(node: Node, damage_amount: int):
#	upon being damaged, send a (local) signal that we've been hit
	if damageable_node.health > 0:
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", death_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
