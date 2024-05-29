extends StaticBody2D

## A tile that prevents the player from moving until it's retracted.
## The name MUST include [code]#num[/code] at the end and it has to be unique for the whole project.
class_name SpikeTile

## Assign the numbers for specific button or similar tiles that will activate the spike
## If you don't want this spike to be interactible, set the number button as -1
@export var number_button: Array[int]

## Reverse the starting position. e.g. Hit a button to raise a spike
@export var is_reverse: bool = false 

## Shows minicam when this spike is retracted or raised offscreen.
## It will show 5x5 tiles around the spike
@export var show_minicam: bool = false

## Play "FlameRaise" and "FlameRetract" instead of "SpikeRaise" and "SpikeRetract" as defined in [SoundVar]. [br][br]
## [SpikeFlame] and [SpikeFrostfire] should play this sound
@export var flame_sound: bool = false

@onready var state = $AnimationTree.get("parameters/playback")
@onready var is_other_state: bool = false
@onready var raise_layer: int = collision_layer
@onready var retract_layer: int = 8
@onready var is_raised: bool
@onready var attempt_to_raise: bool
@onready var do_not_raise: bool = false
@onready var player_current: Dictionary
@onready var offscreen: bool = true

var sound_raise: String = "SpikeRaise"
var sound_retract: String = "SpikeRetract"
var minicam: MiniCam

func _ready():
	if flame_sound:
		sound_raise = "FlameRaise"
		sound_retract = "FlameRetract"
	if is_reverse:
		retract(false)
	else:
		raise(false)
	attempt_to_raise = is_raised
	if show_minicam:
		var visnotif: VisibleOnScreenNotifier2D = get_node_or_null("VisibleOnScreenNotifier2D")
		if visnotif == null: return
		visnotif.connect("screen_entered", _on_screen)
		visnotif.connect("screen_exited", _off_screen)
		minicam = get_tree().get_root().find_child("MiniCam", true, false)

## Raise the spike, preventing Kat and Gon from passing through
func raise(play_sound = true):
	state.travel("raised")
	collision_layer = raise_layer
	collision_mask = raise_layer
	is_raised = true
	if play_sound:
		Sound.stop(sound_retract)
		Sound.play(sound_raise)
	if show_minicam and offscreen and minicam != null:
		minicam.show_cam(global_position)

## Retract the spike, allowing Kat and Gon to pass through
func retract(play_sound = true):
	state.travel("retracted")
	collision_layer = retract_layer
	collision_mask = retract_layer
	is_raised = false
	if play_sound: 
		Sound.stop(sound_raise)
		Sound.play(sound_retract)
	if show_minicam and offscreen and minicam != null:
		minicam.show_cam(global_position)

## Detect the state for all buttons this spike is assigned to before switching its state
func detect_button_presses():
	if is_other_state:
		some_button_deactive()
	else:
		all_button_active()

## Every state of the buttons that are assigned this object must be true. [br]
## In other word, all buttons must be activated in order to go into the other state (from initial state).
func all_button_active(): 
	for number in number_button:
		if RoomVar.button_states[number] != true:
			return
	if is_reverse:
		attempt_to_raise = true
		if not do_not_raise:
			raise()
	else:
		retract()
		attempt_to_raise = is_raised
	is_other_state = true

## At least one state of the buttons that are assigned this object must be false. [br]
## In other word, deactivating one button after activating all will make the spike go back to its initial state.
func some_button_deactive(): 
	for number in number_button:
		if RoomVar.button_states[number] != true:
			if is_reverse:
				retract()
				attempt_to_raise = is_raised
			else:
				attempt_to_raise = true
				if not do_not_raise:
					raise()
			is_other_state = false
			return

## Ignore the button check and go straight to switching the spike's state.
func immediate_button_presses():
	if is_other_state:
		if is_reverse:
			retract()
			attempt_to_raise = is_raised
		else:
			attempt_to_raise = true
			if not do_not_raise:
				raise()
		is_other_state = false
	else:
		if is_reverse:
			attempt_to_raise = true
			if not do_not_raise:
				raise()
		else:
			retract()
			attempt_to_raise = is_raised
		is_other_state = true

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
				raise()

func _on_screen():
	offscreen = false

func _off_screen():
	offscreen = true
