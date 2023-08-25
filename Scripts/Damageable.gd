class_name Damageable extends Node

@export var health: float = 20 : 
	get:
		return health
	set(new_health):
		SignalBus.emit_signal("on_health_changed", get_parent(), new_health - health)
		health = new_health
@export var await_death_animation: bool = false

func hit(damage: int):
	health -= damage
	if health <= 0:
		# manage the queue_free in the entity itself then
		if not await_death_animation:
			get_parent().queue_free()
