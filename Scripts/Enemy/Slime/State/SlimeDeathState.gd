class_name SlimeDeathState extends State

@export var slime_death_node: String
@export var slime_death_animation: String
@export var slime_collision_box = CollisionShape2D

func on_enter():
	playback.travel(slime_death_node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == slime_death_animation:
		character.queue_free()
