class_name MinionSpawningState extends State

@export var minion_releasing_state : State
@export var necromancer_hitbox: CollisionShape2D

@onready var minion_unleash_timer : Timer = $MinionUnleashTimer
@onready var minion_spawn_interval : Timer = $MinionSpawnInterval

var minions : Array[NecromancerMinion]
var minion_to_release := 0

const MAX_MINIONS := 6

func spawn_minion_ring():
	minion_spawn_interval.start()
	
func _get_diagonal(size: Vector2) -> float:
	return sqrt(pow(size.y, 2) + pow(size.x, 2))
	
func get_minion_spawn_position():
	var base_position : Vector2 = necromancer_hitbox.global_position
	var minion_spawn_radius := _get_diagonal(necromancer_hitbox.shape.size)
	base_position.y -= necromancer_hitbox.shape.size.y / 2.0
	var minion_angle = PI * (minions.size()) * (2.0 / MAX_MINIONS)
	var x_offset = cos(minion_angle) * minion_spawn_radius
	var y_offset = sin(minion_angle) * minion_spawn_radius
	base_position += Vector2(x_offset, y_offset)
	return base_position

func spawn_minion():
	var minion = character.necromancer_minion.instantiate()
	minion.seeking = character.seeking
	minion.position = get_minion_spawn_position()
	minion.activate_seek = false
	minions.append(minion)
	self.add_child(minion)

func on_enter():
	spawn_minion_ring()

func on_exit():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	
	pass

# TODO: just make a separate state machine for minion spawning
func _on_minion_spawn_interval_timeout():
	spawn_minion()
	if minions.size() >= MAX_MINIONS:
		minion_spawn_interval.stop()
		next_state = minion_releasing_state

func _on_minion_unleash_timer_timeout():
	var released_minion = minions[minion_to_release]
	minion_to_release += 1
	released_minion.activate_seek = true
	if minion_to_release >= MAX_MINIONS:
		minion_to_release = 0
		minion_unleash_timer.stop()
		minion_spawn_interval.start()
