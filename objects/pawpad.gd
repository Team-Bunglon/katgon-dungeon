extends ButtonToggle

## The other pawpad that will be manipulated when this button is pressed.
@export var other_pawpad_name: Array[String]
@onready var other_pawpad: Array[Node]

func _ready():
	for p in other_pawpad_name:
		other_pawpad.append(get_tree().get_root().find_child(p, true, false))
	super._ready()

func hit():
	if not is_active:
		is_active = true
		$Sprite2D.frame = 1
		RoomVar.button_states[number] = true
		$PushSound.play()
		for n in target_node:
			n.immediate_button_presses()
		for p in other_pawpad:
			p.hit_indirect()

func hit_indirect():
	if is_active:
		is_active = false
		$Sprite2D.frame = 0
		RoomVar.button_states[number] = false
		for n in target_node:
			n.immediate_button_presses()


