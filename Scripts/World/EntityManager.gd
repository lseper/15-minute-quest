class_name EntityManager extends Node2D

func spawn_entity(spawn_position: Vector2, entity: PackedScene):
	var entity_instance = entity.instantiate()
	print("spawning " + entity_instance.name + " at " + str(spawn_position.x) + ", " + str(spawn_position.y))
	entity_instance.position = spawn_position
	self.add_child(entity_instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("on_entity_spawned", spawn_entity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
