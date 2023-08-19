extends State

@export var death_node: String

# Called when the node enters the scene tree for the first time.
func on_enter():
	playback.travel(death_node)
	character.velocity.x = 0
# should already be done, but for testing purposes putting this here
	character.health = 0

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
