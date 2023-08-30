class_name NecromancerMinionSeekState extends State

@export var seek_animation : String
@export var death_state : NecromancerMinionDeathState
var seek : bool

func get_seeking_vector_normalized():
	if character.seeking != null:	
		return (character.seeking.global_position - character.global_position).normalized()
	else:
		return Vector2.ZERO

func state_process(delta):
	if not seek:
		return
	var normalized_direction = get_seeking_vector_normalized()
	character.velocity += normalized_direction * character.boost

func on_enter():
	seek = false
	playback.travel(seek_animation)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_despawn_timer_timeout():
	next_state = death_state

func _on_seek_delay_timeout():
	seek = true
