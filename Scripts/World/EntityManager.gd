class_name EntityManager extends Node2D

func spawn_entity(spawn_position: Vector2, entity: Node2D):
	entity.position = spawn_position
	print("spawning entity")
	self.add_child(entity)

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("on_entity_spawned", spawn_entity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
