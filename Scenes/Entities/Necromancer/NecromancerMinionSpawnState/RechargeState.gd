class_name RechargingState extends State

@export var spawn_state : SpawningMinionsState
@onready var recharge_timer = $RechargeInterval

func on_enter():
	recharge_timer.start()

func on_exit():
	recharge_timer.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_recharge_interval_timeout():
	next_state = spawn_state
