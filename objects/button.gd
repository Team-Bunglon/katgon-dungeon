extends StaticBody2D

## A tile that can give signal to other tile when hit (SpikeTile at the moment)
## The name MUST include #num at the end and it has to be unique for the whole project.
class_name ButtonTile

@export var target_name: Array[String]
@onready var number = get_number()
@onready var target_node: Array[SpikeTile]
@onready var has_pressed: bool = false
	
func _ready():
	for n in target_name:
		target_node.append(get_tree().get_root().find_child(n, true, false))
	RoomVar.button_states[number] = false

func hit():
	$Sprite2D.frame = 1
	if not has_pressed:
		$ButtonOnSound.play()
		has_pressed = true
	RoomVar.button_states[number] = true
	for n in target_node:
		n.detect_button_presses()

func get_number():
	if "#" in name:
		return int(name.get_slice("#",1))
	else:
		assert(false, "You forgot to put #int after a button name.")


