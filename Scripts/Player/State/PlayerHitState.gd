class_name PlayerHitState extends HitState

@onready var invincibility_timer = $InvincibilityTimer
@export var neutral_state : State

func on_enter():
	invincibility_timer.start()
	
func on_exit():
	invincibility_timer.stop()

func _on_invincibility_timer_timeout():
	next_state = neutral_state
