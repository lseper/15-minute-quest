class_name NecromancerAttackState extends State

@export var minor_spell_animation: String
@export var skull_spell_animation: String
@export var major_spell_animation: String
@export var idle_state: NecromancerIdleState

@onready var spell_timer : Timer = $SpellTimer

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
	SignalBus.emit_signal("on_entity_spawned", spawn_position, character.dark_spell)

func minor_spell():
	spell_timer.start()
	spells_to_cast = MINOR_SPELLS
	playback.travel(minor_spell_animation)
	
func major_spell():
	playback.travel(major_spell_animation)
	
func skull_spell():
	playback.travel(skull_spell_animation)

func on_enter():
	var spell_choice = randi_range(0, SPELL.size() - 1)
	if spell_choice == SPELL.MINOR:
		minor_spell()
	elif spell_choice == SPELL.SKULL:
		minor_spell()
	else:
		minor_spell()
		
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
		spell_timer.stop()
		spells_cast = 0
