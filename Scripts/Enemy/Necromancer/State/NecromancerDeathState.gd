class_name NecromancerDeathState extends State

@export var death_animation: String
@export var necromancer_collision: CollisionShape2D

func on_enter():
	playback.travel(death_animation)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == death_animation:
		character.queue_free()
