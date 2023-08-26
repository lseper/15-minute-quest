class_name NecromancerAttackState extends State

@export var minor_spell_animation: String
@export var skull_spell_animation: String
@export var major_spell_animation: String
@export var idle_state: NecromancerIdleState

enum SPELL {
	MINOR,
	SKULL,
	MAJOR
}

var chosen_spell = spawn_minion

func spawn_minion():
	var minion = character.necromancer_minion.instantiate()
	minion.seeking = character.seeking
	minion.position = character.position
	self.add_child(minion)

func minor_spell():
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
		skull_spell()
	else:
		major_spell()
		
func on_exit():
	spawn_minion()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name):
	if [minor_spell_animation, major_spell_animation, skull_spell_animation].has(anim_name):
		next_state = idle_state
