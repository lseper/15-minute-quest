class_name NecromancerIdleState extends State

@export var idle_animation : String
@export var attack_state : NecromancerAttackState
@export var death_state : NecromancerDeathState
@export var hurt_state : NecromancerHurtState
@onready var spell_timer : Timer = $AttackDelayTimer
@export var damageable_node: Damageable

@onready var curr_health : int

var invincible := false
const MIN_SPELL_WAIT_TIME := 5.0
const MAX_SPELL_WAIT_TIME := 10.0

func hurt():
	next_state = hurt_state
	
func die():
	next_state = death_state

func get_spell_wait_time():
	return randf_range(MIN_SPELL_WAIT_TIME, MAX_SPELL_WAIT_TIME)	

func on_enter():
	curr_health = damageable_node.health
	spell_timer.start()
	playback.travel(idle_animation)

func on_exit():
	spell_timer.stop()
	curr_health = damageable_node.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
#	enemy was hit
	if curr_health > damageable_node.health:
		if damageable_node.health > 0:
			hurt()
		else:
			die()

func _on_vulnerable_timer_timeout():
	next_state = attack_state
	spell_timer.wait_time = get_spell_wait_time()
