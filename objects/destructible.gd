extends StaticBody2D

## An object that can be destroyed
class_name Destructible

@export var boulder_sound: bool = false ## Play "DestoryBoulder" instead of "DestroyTwig" as defined in [SoundVar]
@onready var state = $AnimationTree.get("parameters/playback")

var sound: String = "DestroyTwig"
	
func _ready():
	if boulder_sound: sound = "DestroyBoulder"

func hit():
	Sound.play(sound)
	state.travel("destroyed")

func _on_animation_tree_animation_finished(anim_name:StringName):
	if anim_name == "destroyed":
		queue_free()
