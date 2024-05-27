extends StaticBody2D

## An object that can be destroyed
class_name Destructible

@onready var state = $AnimationTree.get("parameters/playback")
	
func hit():
	state.travel("destroyed")
