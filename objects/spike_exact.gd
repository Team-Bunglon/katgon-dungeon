extends SpikeTile

## A variant of spike that requires exact button combination in order to change its state. [br][br]
## It's recommended that you use [ButtonToggle] (the yellow button) as it can be unpressed.
class_name SpikeExact

## The spike would only get to the other state if, and only if, every button matches
## the exact condition that has been given to number_button and number_button_opposite. [br][br]
## [param number_button] would be the buttons that must be pushed. [br]
## [param number_button_opposite] would be the opposite; the buttons that must be unpressed. [br][br]
## It's recommended that you use [ButtonToggle] (the yellow button) as it can be unpressed.
@export var number_button_opposite: Array[int]

## Once this spike has been retracted, it will be disabled (cannot be raised again) as soon as the player steps on the spike. 
@export var stay_retracted = false

## Another exact Spike that will be disabled if this spike id disabled
@export var other_spike_to_stay_retracted: Array[int] 

## The exact condition of which the spike would get to the other state.
@onready var number_button_condition: Dictionary

## The spike is disabled and can't never be raised again unless the game is restarted.
@onready var disabled_spike = false

## The other [SpikeExact] to disable.
@onready var other_spike_node: Array[SpikeExact]

func _ready():
	for n in number_button:
		number_button_condition[n] = true
	for m in number_button_opposite:
		number_button_condition[m] = false
	for s in other_spike_to_stay_retracted:
		other_spike_node.append(get_tree().get_root().find_child("SpikeExact#" + str(s), true, false))
	super._ready()

func detect_button_presses():
	if disabled_spike:
		return
	if is_other_state:
		some_button_unmatch()
	else:
		all_button_match()
	print(is_raised)

func all_button_match():
	for number in number_button_condition:
		if RoomVar.button_states[number] != number_button_condition[number]:
			return
	if is_reverse:
		raise()
	else:
		retract()
	is_other_state = true

func some_button_unmatch():
	for number in number_button_condition:
		if RoomVar.button_states[number] != number_button_condition[number]:
			if is_reverse:
				retract()
			else:
				raise()
			is_other_state = false
			return

# Disable Spike from raising ever again.
func disable():
	disabled_spike = true
	Sound.play("SpikeDisable")
	state.travel("disabled")

func _on_body_detector_body_entered(body:Node2D):
	if "Player" in body.name and stay_retracted and not is_raised and not disabled_spike:
		disable()
		for s in other_spike_node:
			s.disable()
