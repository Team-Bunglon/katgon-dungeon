extends StaticBody2D

## A tile that can give signal to other tile when hit (SpikeTile at the moment)
## The name MUST include #num at the end and it has to be unique for the whole project.
class_name ButtonTile

@export var target_name: Array[String]	## The name of the target [SpikeTile] objects this button should interact with when being hit.
@export var torch_sound: bool = false	## Play "ButtonTorch" instead of "ButtonOn" as defined in [SoundVar]
@onready var number = get_number()
@onready var target_node: Array[SpikeTile]
@onready var has_pressed: bool = false

var sound: String = "ButtonOn"
	
func _ready():
	if torch_sound:
		sound = "ButtonTorch"
	for n in target_name:
		target_node.append(get_tree().get_root().find_child(n, true, false))
	RoomVar.button_states[number] = false

func hit():
	$Sprite2D.frame = 1
	if not has_pressed:
		Sound.play(sound)
		has_pressed = true
	RoomVar.button_states[number] = true
	for n in target_node:
		n.detect_button_presses()

func get_number():
	if "#" in name:
		return int(name.get_slice("#",1))
	else:
		return name.to_int()
