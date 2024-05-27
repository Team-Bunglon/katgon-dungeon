extends ButtonTile
class_name ButtonToggle

## Set button to active at the start
@export var is_active: bool

func _ready():
	for n in target_name:
		target_node.append(get_tree().get_root().find_child(n, true, false))
	RoomVar.button_states[number] = is_active
	$Sprite2D.frame = 1 if is_active else 0

func hit():
	is_active = not is_active
	$Sprite2D.frame = 1 if is_active else 0
	RoomVar.button_states[number] = is_active
	if is_active:
		$ButtonOnSound.play()
	else:
		$ButtonOffSound.play()
	for n in target_node:
		n.detect_button_presses()
