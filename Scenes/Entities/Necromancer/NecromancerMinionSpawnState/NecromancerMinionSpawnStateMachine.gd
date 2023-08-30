class_name NecromancerMinionSpawnStateMachine extends CharacterStateMachine

var minions : Array[NecromancerMinion] = []

func _ready():
	for child in get_children():
		if child is SpawningMinionsState:
			child.minions = minions
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
