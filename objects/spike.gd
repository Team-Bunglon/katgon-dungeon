extends StaticBody2D

## A tile that prevents the player from moving until it's activated.
## The name MUST include #num at the end and it has to be unique for the whole project.
class_name SpikeTile

## Assign the numbers for specific button or similar tiles that will activate the spike
## If you don't want this spike to be interactible, set the number button as -1
@export var number_button: Array[int]

## Reverse the starting position. e.g. Hit a button to raise a spike
@export var is_reverse: bool = false 

@onready var state = $AnimationTree.get("parameters/playback")
@onready var is_other_state: bool = false
@onready var raise_layer: int = 15
@onready var retract_layer: int = 8
@onready var is_raised: bool
@onready var attempt_to_raise: bool
@onready var do_not_raise: bool = false
@onready var player_current: Dictionary

signal state_changed(play_sound: bool, is_retract: bool)

func _ready():
	if is_reverse:
		retract(false)
	else:
		raise(false)
	attempt_to_raise = is_raised
	if len(number_button) == 0:
		assert(false, name + ": You forgot to give this spike the list of button #")

## Detect the state for all buttons this spike is assigned to before switching its state
func detect_button_presses():
	if is_other_state:
		some_button_deactive()
	else:
		all_button_active()

## Ignore the button check and goes straight to switchng the spike's state:
func immediate_button_presses():
	if is_other_state:
		if is_reverse:
			retract(not do_not_raise)
			attempt_to_raise = is_raised
		else:
			attempt_to_raise = true
			if not do_not_raise:
				raise(true)
		is_other_state = false
	else:
		if is_reverse:
			attempt_to_raise = true
			if not do_not_raise:
				raise(true)
		else:
			retract(not do_not_raise)
			attempt_to_raise = is_raised
		is_other_state = true

func raise(play_sound: bool):
	state.travel("raised")
	collision_layer = raise_layer
	collision_mask = raise_layer
	is_raised = true
	state_changed.emit(play_sound, false)

func retract(play_sound: bool):
	state.travel("retracted")
	collision_layer = retract_layer
	collision_mask = retract_layer
	is_raised = false
	state_changed.emit(play_sound, true)

## All button states that this object assign to must be true
func all_button_active(): 
	for number in number_button:
		if RoomVar.button_states[number] != true:
			return
	if is_reverse:
		attempt_to_raise = true
		if not do_not_raise:
			raise(true)
	else:
		retract(not do_not_raise)
		attempt_to_raise = is_raised
	is_other_state = true

## At least one button state that this object assign to must be false
func some_button_deactive(): 
	for number in number_button:
		if RoomVar.button_states[number] != true:
			if is_reverse:
				retract(not do_not_raise)
				attempt_to_raise = is_raised
			else:
				attempt_to_raise = true
				if not do_not_raise:
					raise(true)
			is_other_state = false
			return

func _on_body_detector_body_entered(body:Node2D):
	if "Player" in body.name:
		player_current[body.name] = true
		do_not_raise = true

func _on_body_detector_body_exited(body:Node2D):
	if "Player" in body.name:
		player_current.erase(body.name)
		if player_current.is_empty():
			do_not_raise = false
			if attempt_to_raise:
				raise(true)
				$RaiseSound.play()
