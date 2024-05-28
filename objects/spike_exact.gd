extends SpikeTile
class_name SpikeExact

## The spike would only get to the other state if, and only if, every button matches
## the exact condition that has been given to number_button and number_button_opposite.
## number_buttons would be the buttons that must be activated.
## this variable would be the opposite; the buttons that must be deactivated.
@export var number_button_opposite: Array[int]
@onready var number_button_condition: Dictionary

## Once this spike has been retracted, it cannot be raised again
## as soon as the player steps on the spike while it's being retracted 
@export var stay_retracted = false
@onready var do_not_raise_ever = false

func _ready():
	for n in number_button:
		number_button_condition[n] = true
	for m in number_button_opposite:
		number_button_condition[m] = false
	super._ready()

func detect_button_presses():
	if is_other_state:
		some_button_unmatch()
	else:
		all_button_match()

func all_button_match():
	for number in number_button_condition:
		if RoomVar.button_states[number] != number_button_condition[number]:
			return
	if is_reverse and not do_not_raise_ever:
		raise(true)
	else:
		retract(not do_not_raise_ever)
	is_other_state = true

func some_button_unmatch():
	for number in number_button_condition:
		if RoomVar.button_states[number] != number_button_condition[number]:
			if is_reverse:
				retract(not do_not_raise_ever)
			elif not do_not_raise_ever:
				raise(true)
			is_other_state = false
			return

func _on_body_detector_body_entered(body:Node2D):
	if "Player" in body.name and stay_retracted:
		do_not_raise_ever = true
