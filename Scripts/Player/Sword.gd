extends Area2D

@export var damage: int = 10
@export var player: Player
@export var attack_collision_box: AttackCollision
@export var special_collision_box: SpecialCollision

func _ready():
	player.connect("facing_direction_changed", on_player_facing_direction_changed)

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)
	pass # Replace with function body.

func on_player_facing_direction_changed(facing_right: bool):
	if facing_right:
		attack_collision_box.position = attack_collision_box.facing_right_position
		special_collision_box.position = special_collision_box.facing_right_position
	else:
		attack_collision_box.position = attack_collision_box.facing_left_position
		special_collision_box.position = special_collision_box.facing_left_position
