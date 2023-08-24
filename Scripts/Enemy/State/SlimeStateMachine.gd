class_name SlimeStateMachine extends CharacterStateMachine

func can_fall():
	return current_state.can_fall
	
func _ready():
	super()
	for child in get_children():
		if child is SlimeSpawnState:
			child.spawn_ceiling = get_parent().spawn_ceiling
