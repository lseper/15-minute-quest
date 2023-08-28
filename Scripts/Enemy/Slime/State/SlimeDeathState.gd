class_name SlimeDeathState extends State

@export var slime_death_node: String
@export var slime_death_animation: String
@export var slime_collision_box = CollisionShape2D

@export var rare_drop_chance := 0.10
@export var drop_chance := 0.5
@export var common_pickup: PackedScene
@export var rare_pickup: PackedScene

func on_enter():
	var spawns_drop = randf_range(0.0, 1.0)
	if spawns_drop <= drop_chance:
		if spawns_drop <= rare_drop_chance:
			character.drop_pickup(rare_pickup)
		else:
			character.drop_pickup(common_pickup)
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
