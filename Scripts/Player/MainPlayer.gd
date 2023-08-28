class_name MainPlayer extends Player

signal collected(collectable)

func collect(collectable : Pickup):
	collected.emit(collectable)
