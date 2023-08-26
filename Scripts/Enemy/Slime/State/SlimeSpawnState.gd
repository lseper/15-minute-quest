class_name SlimeSpawnState extends State

@export var spawn_rise_velocity : int = -50
@export var slime_collision_box : SlimeCollisionBox
@export var slime_ground_state: SlimeGroundState
@export var slime_spawn_animation: String
@export var slime_death_state: SlimeDeathState
@export var damageable_node: Damageable
var spawn_ceiling: int

func on_enter():
	playback.travel(slime_spawn_animation)
	character.velocity.y = spawn_rise_velocity
	slime_collision_box.disabled = true

func on_exit():
	character.velocity.y = 0
	slime_collision_box.disabled = false
#	this is hacky, but whatever
	character.set_collision_mask_value(1, true)
#	character.set_collision_mask_value(2, true)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if damageable_node.health <= 0:
		next_state = slime_death_state
#	prevent character from blocking it basically
	if character.velocity.y > spawn_rise_velocity and get_parent().current_state == self:
		character.velocity.y = spawn_rise_velocity
	var slime_bottom = character.position.y + int(slime_collision_box.shape.size.y / 2.0)
	if character.position.y < spawn_ceiling:
		next_state = slime_ground_state
