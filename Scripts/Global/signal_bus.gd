extends Node

signal on_health_changed(node: Node, amount_changed: int)

signal on_entity_spawned(spawn_position : Vector2, entity: PackedScene)

signal on_enemy_death()
