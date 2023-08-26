extends Area2D

@export var damage: int = 5
@export var slime: Player
@export var slime_hitbox_collision: SlimeHitboxCollision

func _ready():
	slime.connect("facing_direction_changed", on_player_facing_direction_changed)

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)

func on_player_facing_direction_changed(facing_right: bool):
	if facing_right:
		slime_hitbox_collision.position = slime_hitbox_collision.facing_right_position
	else:
		slime_hitbox_collision.position = slime_hitbox_collision.facing_left_position
