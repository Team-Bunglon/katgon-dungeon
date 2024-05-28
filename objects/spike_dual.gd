extends SpikeTile

## A variant of flame/frostfire spike that combines the two into one tile.
## Cannot be retracted. Any interaction with this spike will only change its flame type. [br][br]
## The default state is flame state. Change to frostfire state with [param is_reverse].
class_name SpikeDual

@onready var flame_layer: int = 45
@onready var frost_layer: int = 78

func _ready():
	sound_raise = "FlameRaise"
	sound_retract = "FlameRetract"
	is_raised = true
	if is_reverse:
		flame_to_frost(false)
	else:
		frost_to_flame(false)

func frost_to_flame(play_sound = true):
	state.travel("Flame")
	collision_layer = flame_layer
	collision_mask = flame_layer
	if play_sound: Sound.play(sound_raise)

func flame_to_frost(play_sound = true):
	state.travel("Frost")
	collision_layer = frost_layer
	collision_mask = frost_layer 
	if play_sound: Sound.play(sound_raise)

func all_button_active(): 
	for number in number_button:
		if RoomVar.button_states[number] != true:
			return
	if is_reverse:
		frost_to_flame()
	else:
		flame_to_frost()
	is_other_state = true

func some_button_deactive(): 
	for number in number_button:
		if RoomVar.button_states[number] != true:
			if is_reverse:
				flame_to_frost()
			else:
				frost_to_flame()
			is_other_state = false
			return

func immediate_button_presses():
	if is_other_state:
		if is_reverse:
			flame_to_frost()
		else:
			frost_to_flame()
		is_other_state = false
	else:
		if is_reverse:
			frost_to_flame()
		else:
			flame_to_frost()
		is_other_state = true
