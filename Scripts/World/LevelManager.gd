class_name LevelManager extends Node

signal level_up(level: int)

signal experience_change(new_experience: int)

signal boss_fight(boss: Boss)

enum Boss {
	NECROMANCER,
	DRAGON
}

const BOSS_FIGHT_LEVELS = {Boss.NECROMANCER: 10, Boss.DRAGON: 20}

# this array stores the experience needed to get to the NEXT level [1 -> 2, 2 -> 3, ... etc.]

# const experience_to_next_levels = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
const experience_to_next_levels = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

var curr_level := 1
var experience_to_next_level := experience_to_next_levels[0]

func _gain_experience(experience: int):
	experience_to_next_level -= experience
	experience_change.emit(experience_to_next_level)
	if experience_to_next_level <= 0:
		_level_up()

func _level_up():
	curr_level += 1
	if curr_level > experience_to_next_levels.size():
		push_error('Error: player level is now %i and has exceeded the size of the  exp to next level array :(' % curr_level)
	else:	
		# subtract 1 because 0-indexed
		experience_to_next_level = experience_to_next_levels[curr_level - 1]
	level_up.emit(curr_level)
	experience_change.emit(experience_to_next_level)
	SignalBus.emit_signal("on_difficulty_changed", curr_level)
	for boss in BOSS_FIGHT_LEVELS.keys():
		var level_needed = BOSS_FIGHT_LEVELS.get(boss)
		if level_needed == curr_level:
			boss_fight.emit(boss)
			break
			
func _initialize_starting_experience_and_level():
	level_up.emit(1)
	experience_change.emit(experience_to_next_level)

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("on_enemy_death", _gain_experience)
	# player starts at level "0" so when game loads, they go to level 1
	_initialize_starting_experience_and_level()
	# emit our starting level and experience needed to get to the next level
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
