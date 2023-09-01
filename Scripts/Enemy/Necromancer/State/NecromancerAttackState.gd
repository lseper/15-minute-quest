class_name NecromancerAttackState extends State

@export var minor_spell_animation: String
@export var skull_spell_animation: String
@export var major_spell_animation: String
@export var idle_state: NecromancerIdleState

@onready var minor_spell_timer : Timer = $MinorSpellTimer
@onready var major_spell_timer : Timer = $MajorSpellTimer

enum SPELL {
	MINOR,
	SKULL,
	MAJOR
}

var spells_cast = 0

const MINOR_SPELLS = 3
const MAJOR_SPELLS = 5
const SKULL_SPELLS = 8

var spells_to_cast = 0

func _get_spell_spawn_position():
	if character.seeking != null:
		return character.seeking.position
	else:
		return character.position
	
func _spawn_spell_at_player_foot():
	var spawn_position = _get_spell_spawn_position()
	SignalBus.emit_signal("on_entity_spawned", spawn_position, character.dark_spell.instantiate())
	
func _get_direction_towards_player() -> Vector2:
	if character.seeking != null:
		if (character.seeking.position - character.position).x > 0:
			return Vector2(1, 0)
		else:
			return Vector2(-1, 0)
	else:
		return Vector2(1, 0)

func _spawn_bullet_spell_towards_player():
	var spawn_position = character.position
	var velocity = _get_direction_towards_player()
	var dark_bullet_spell_instance = character.dark_bullet_spell.instantiate()
	dark_bullet_spell_instance.velocity *= velocity
	print(spawn_position)
	SignalBus.emit_signal("on_entity_spawned", spawn_position, dark_bullet_spell_instance)

func minor_spell():
	minor_spell_timer.start()
	spells_to_cast = MINOR_SPELLS
	playback.travel(minor_spell_animation)
	
func major_spell():
	major_spell_timer.start()
	print("casting major spell")
	spells_to_cast = MAJOR_SPELLS
	playback.travel(major_spell_animation)
	
func skull_spell():
	playback.travel(skull_spell_animation)

func on_enter():
	var spell_choice = randi_range(0, SPELL.size() - 1)
	if spell_choice == SPELL.MINOR:
		minor_spell()
	elif spell_choice == SPELL.SKULL:
		major_spell()
	else:
		major_spell()
		
func on_exit():
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name):
	if [minor_spell_animation, major_spell_animation, skull_spell_animation].has(anim_name):
		next_state = idle_state


func _on_minor_spell_timer_timeout():
	_spawn_spell_at_player_foot()
	spells_cast += 1
	if spells_cast >= spells_to_cast:
		minor_spell_timer.stop()
		spells_cast = 0


func _on_major_spell_timer_timeout():
	_spawn_bullet_spell_towards_player()
	spells_cast += 1
	if spells_cast >= spells_to_cast:
		major_spell_timer.stop()
		spells_cast = 0
