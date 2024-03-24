class_name MainPlayer extends Player

@onready var special_state : SpecialState = $CharacterStateMachine/Special

@export var level_up_announcement : PackedScene

signal collected(collectable)

func collect(collectable : Pickup):
	collected.emit(collectable)
	collectable.buff(self)
	collectable.debuff(self)

func _on_level_manager_level_up(level):
	if level == 1:
		return
	var annnouncement_instance = level_up_announcement.instantiate()
	annnouncement_instance.text = "Level Up!"
	print("Announcing level up")
	self.add_child(annnouncement_instance)
	annnouncement_instance.position += Vector2(0, -50)
