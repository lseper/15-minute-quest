class_name Damageable extends Node

signal on_hit(node: Node, damage_taken: int)

@export var vulnerable := true

@export var experience := 1
@export var health: float = 20 : 
	get:
		return health
	set(new_health):
		SignalBus.emit_signal("on_health_changed", get_parent(), new_health - health)
		# ensure floors and ceiling on health
		health = new_health
@export var await_death_animation: bool = false

func hit(damage: int):
	health -= damage
	emit_signal("on_hit", get_parent(), damage)
	if health <= 0:
		SignalBus.emit_signal("on_enemy_death", experience)
		# manage the queue_free in the entity itself then
		if not await_death_animation:
			get_parent().queue_free()
