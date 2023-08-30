class_name SpawningMinionsState extends State

@export var necromancer_collision_box : CollisionShape2D
@export var recharge_state : State
@onready var radius := _get_hypotenuse()
@onready var spawn_timer := $SpawnInterval
@onready var recharge_timer := $RechargeInterval

var minions : Array[NecromancerMinion]
const MAX_MINIONS := 6

func _get_hypotenuse() -> float:
	var x = necromancer_collision_box.shape.size.x
	var y = necromancer_collision_box.shape.size.y
	return sqrt(pow(x, 2) + pow(y, 2))

func get_minion_spawn_position():
	var base_position = necromancer_collision_box.global_position
#	print("global position: %.0f %.0f" % [base_position.x, base_position.y])
	var angle = (PI * 2.0 * minions.size()) / MAX_MINIONS
	base_position.x += cos(angle) * radius
	base_position.y += sin(angle) * radius
	return base_position

func spawn_minion():
	var minion = character.necromancer_minion.instantiate()
	self.add_child(minion)
	minion.seeking = character.seeking
	minion.global_position = get_minion_spawn_position()
	minions.append(minion)
	
func on_enter():
	spawn_timer.start()
	
func on_exit():
	minions.clear()
	spawn_timer.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_spawn_interval_timeout():
	if minions.size() < MAX_MINIONS:
		spawn_minion()
	else:
		next_state = recharge_state
