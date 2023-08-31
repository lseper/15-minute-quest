class_name MainPlayer extends Player

@onready var special_state : SpecialState = $CharacterStateMachine/Special

signal collected(collectable)

func collect(collectable : Pickup):
	collected.emit(collectable)
	collectable.buff(self)
	collectable.debuff(self)
