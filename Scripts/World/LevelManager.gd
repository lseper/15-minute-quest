class_name LevelManager extends Node

signal level_up(level: int)

signal boss_fight(boss: Boss)

enum Boss {
	NECROMANCER,
	DRAGON
}

const BOSS_FIGHT_LEVELS = {Boss.NECROMANCER: 10, Boss.DRAGON: 20}

var curr_level := 0

var experience_to_next_level := 10

var curr_experience := 0

func _gain_experience(experience: int):
	curr_experience += experience
	if curr_experience >= experience_to_next_level:
		_level_up()

func _level_up():
	curr_level += 1
	curr_experience = 0
	level_up.emit(curr_level)
	for boss in BOSS_FIGHT_LEVELS.keys():
		var level_needed = BOSS_FIGHT_LEVELS.get(boss)
		if level_needed == curr_level:
			boss_fight.emit(boss)

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("on_enemy_death", _gain_experience)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
