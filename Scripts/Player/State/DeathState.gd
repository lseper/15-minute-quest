extends State

@export var death_node: String
@export var player_hurtbox: CollisionShape2D
# Called when the node enters the scene tree for the first time.
func on_enter():
	playback.travel(death_node)
	character.velocity.x = 0
	player_hurtbox.disabled = true

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass
