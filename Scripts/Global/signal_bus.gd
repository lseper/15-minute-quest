extends Node

signal on_health_changed(node: Node, amount_changed: int)

signal on_entity_spawned(spawn_position : Vector2, entity: Node2D)

signal on_enemy_death(experience: int)

signal on_difficulty_changed(new_difficulty: int)
