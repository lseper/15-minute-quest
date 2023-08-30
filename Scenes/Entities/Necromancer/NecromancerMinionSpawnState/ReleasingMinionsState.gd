class_name ReleasingMinonsState extends State

@export var spawning_minions_state : SpawningMinionsState

@onready var release_timer : Timer = $ReleaseInterval

var minions : Array[NecromancerMinion]

func release_minion():
	if minions.size() > 0:
		var released_minion = minions.pop_front()
		released_minion.seek = true

func on_enter():
	release_timer.start()
	pass
	
func on_exit():
	release_timer.stop()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_release_interval_timeout():
	release_minion()
	if minions.size() <= 0:
		next_state = spawning_minions_state
