extends SpikeTile

@onready var flame_layer: int = 13
@onready var frost_layer: int = 14

signal state_changed_dual(play_sound: bool)

func _ready():
	is_raised = true
	if is_reverse:
		flame_to_frost(false)
	else:
		frost_to_flame(false)
	if len(number_button) == 0:
		assert(false, "You forgot to give a spike the list of button #")

func frost_to_flame(play_sound: bool):
	state.travel("Flame")
	collision_layer = flame_layer
	collision_mask = flame_layer
	state_changed_dual.emit(play_sound)
	pass

func flame_to_frost(play_sound: bool):
	state.travel("Frost")
	collision_layer = frost_layer
	collision_mask = frost_layer 
	state_changed_dual.emit(play_sound)
	pass

func all_button_active(): 
	for number in number_button:
		if RoomVar.button_states[number] != true:
			return
	if is_reverse:
		frost_to_flame(true)
	else:
		flame_to_frost(true)
	is_other_state = true

func some_button_deactive(): 
	for number in number_button:
		if RoomVar.button_states[number] != true:
			if is_reverse:
				flame_to_frost(true)
			else:
				frost_to_flame(true)
			is_other_state = false
			return

func immediate_button_presses():
	if is_other_state:
		if is_reverse:
			flame_to_frost(true)
		else:
			frost_to_flame(true)
		is_other_state = false
	else:
		if is_reverse:
			frost_to_flame(true)
		else:
			flame_to_frost(true)
		is_other_state = true
