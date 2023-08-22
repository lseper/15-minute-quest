class_name Damageable extends Node

@export var health: float = 20 : 
	get:
		return health
	set(new_health):
		SignalBus.emit_signal("on_health_changed", get_parent(), new_health - health)
		health = new_health

func hit(damage: int):
	health -= damage
	if health <= 0:
		get_parent().queue_free()
