extends Label

@export var player_damageable_node: Damageable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_damageable_node != null:
		text = "Health: %f" % player_damageable_node.health
