class_name EntityAnticipationState extends EntityState

@export var anticipation_animation : String
@export var active_state : EntityState
@onready var anticipation_time: Timer = $Timer

func on_enter():
	playback.travel(anticipation_animation)
	
func on_exit():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_timer_timeout():
	next_state = active_state
