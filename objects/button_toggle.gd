extends ButtonTile
class_name ButtonToggle

## Set button to active at the start
@export var is_active: bool

var sound_off: String = "ButtonOff"

func _ready():
	for n in target_name:
		target_node.append(get_tree().get_root().find_child(n, true, false))
	RoomVar.button_states[number] = is_active
	$Sprite2D.frame = 1 if is_active else 0

func hit():
	var sound_current := sound if not is_active else sound_off
	is_active = not is_active
	$Sprite2D.frame = 1 if is_active else 0
	Sound.play(sound_current)
	RoomVar.button_states[number] = is_active
	for n in target_node:
		n.detect_button_presses()
