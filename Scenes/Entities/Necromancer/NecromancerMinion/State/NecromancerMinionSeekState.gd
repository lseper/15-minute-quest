class_name NecromancerMinionSeekState extends State

@export var seek_animation : String
@export var death_state : NecromancerMinionDeathState

func on_enter():
	playback.travel(seek_animation)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_despawn_timer_timeout():
	next_state = death_state
