class_name ItemManager extends Node2D

func drop_pickup(body: Node2D, pickup: PackedScene):
	var pickup_instance = pickup.instantiate()
	pickup_instance.position = body.global_position
	self.add_child(pickup_instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
