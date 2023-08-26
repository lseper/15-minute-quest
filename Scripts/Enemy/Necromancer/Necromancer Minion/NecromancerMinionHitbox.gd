class_name NecromancerMinionHitbox extends Area2D

@export var damage: int = 10
@export var player: Player
@export var hitbox: NecromancerMinionHitboxCollision

func _ready():
	player.connect("facing_direction_changed", on_player_facing_direction_changed)

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)

func on_player_facing_direction_changed(facing_right: bool):
	if facing_right:
		hitbox.position = hitbox.facing_right_position
	else:
		hitbox.position = hitbox.facing_left_position
