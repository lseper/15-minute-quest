class_name PlayerHitState extends HitState

@onready var invincibility_timer = $InvincibilityTimer
@export var ground_state = GroundState

func on_enter():
	invincibility_timer.start()
	invincibility_timer.paused = false
	# TODO: add player hit animation
	
func on_exit():
	invincibility_timer.paused = true

func _on_invincibility_timer_timeout():
	next_state = ground_state
