extends Label

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		text = "Velocity: %.2f %.2f" % [player.velocity.x, player.velocity.y]
	pass
