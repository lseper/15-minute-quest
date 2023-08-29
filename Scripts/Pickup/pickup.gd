class_name Pickup extends Area2D

@export var score_value: int = 100

@onready var pickup_delay_timer := $SpawnTimer
@onready var despawn_timer := $DespawnTimer


func buff(collector: MainPlayer):
	pass
	
func debuff(collector: MainPlayer):
	pass

func _on_body_entered(body):
	if body is MainPlayer:
		body.collect(self)
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_timer_timeout():
#	only allow player to pickup coin after certain time has passed
	set_collision_mask_value(2, true)

func _on_despawn_timer_timeout():
	queue_free()
