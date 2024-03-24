class_name NecromancerAttackState extends State

@export var minor_spell_animation: String
@export var skull_spell_animation: String
@export var major_spell_animation: String
@export var idle_state: NecromancerIdleState
@export var bullet_spells_per_wave := 4
@export var space_between_bullets := 120

@onready var projectResolution := Vector2(ProjectSettings.get("display/window/size/viewport_width"), ProjectSettings.get("display/window/size/viewport_height"))

@onready var minor_spell_timer : Timer = $MinorSpellTimer
@onready var major_spell_timer : Timer = $MajorSpellTimer

enum SPELL {
	MINOR,
	SKULL,
	MAJOR
}

var spells_cast = 0

const MINOR_SPELLS = 3
const MAJOR_SPELLS = 3
const SKULL_SPELLS = 8

var spells_to_cast = 0

func _get_spell_spawn_position():
	if character.seeking != null:
		return character.seeking.position
	else:
		return character.position
		
func _spawn_spell_at_player_foot():
	var spawn_position = Vector2(_get_spell_spawn_position().x, character.ground.global_position.y)
	var dark_spell_instance = character.dark_spell.instantiate()
	var dark_spell_shape = dark_spell_instance.get_node("Hitbox").shape
	spawn_position.y -= (dark_spell_shape.size.y * dark_spell_instance.scale.y) / 2.0
	SignalBus.emit_signal("on_entity_spawned", spawn_position, dark_spell_instance)
	
func _get_direction_towards_player() -> Vector2:
	if character.seeking != null:
		return (character.seeking.position - character.position).normalized()
	else:
		return Vector2(1, 0)

func _spawn_bullet_spell_towards_player():
	var spawn_position = character.position
	var velocity = _get_direction_towards_player() 
	var dark_bullet_spell_instance = character.dark_bullet_spell.instantiate()
	dark_bullet_spell_instance.rotation = (character.seeking.global_position - character.position).angle()
#		lolthis sucks
	dark_bullet_spell_instance.velocity = velocity * dark_bullet_spell_instance.velocity.x
	SignalBus.emit_signal("on_entity_spawned", spawn_position, dark_bullet_spell_instance)
	
func _spawn_bullet_spell_wave():
# 	rough hard code estimate
	var bullets_shot = 0
	var base_position = Vector2(0, 280)
	var space_deducted = randi_range(0, bullet_spells_per_wave)
	while bullets_shot < bullet_spells_per_wave + 1:
		if bullets_shot != space_deducted:
			var dark_bullet_spell_instance = character.dark_bullet_spell.instantiate()
			dark_bullet_spell_instance.velocity *= -1
			var spawn_position = base_position - Vector2(0, space_between_bullets * bullets_shot)
			spawn_position.x = projectResolution.x - 400
			SignalBus.emit_signal("on_entity_spawned", spawn_position, dark_bullet_spell_instance)
		bullets_shot += 1

func minor_spell():
	minor_spell_timer.start()
	spells_to_cast = MINOR_SPELLS
	playback.travel(minor_spell_animation)
	
func major_spell():
	major_spell_timer.start()
	spells_to_cast = MAJOR_SPELLS
	playback.travel(major_spell_animation)
	
func skull_spell():
	playback.travel(skull_spell_animation)

func on_enter():
	var spell_choice = randi_range(0, SPELL.size() - 1)
	if spell_choice == SPELL.MINOR:
		minor_spell()
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
	_spawn_bullet_spell_wave()
	spells_cast += 1
	if spells_cast >= spells_to_cast:
		major_spell_timer.stop()
		spells_cast = 0
