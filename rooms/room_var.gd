extends Node

@onready var button_states = {}
@onready var room_count: int
@onready var player_1_location: String
@onready var player_2_location: String
@onready var visited_location_queue: Array[String] = []
@onready var visited_location = {}

func load_stuff():
	generate_location_visited()
	visited_location_queue = []

## Generate visited_location map if it hasn't been initialized yet.
func generate_location_visited():
	for i in RoomVar.room_count:
		var temp_name: String = "Room#" + str(i+1)
		visited_location[temp_name] = false

## Track of the room both Kat and Gon have visited.
func update_visited_location(room_name: String, is_player_1: bool):
	if visited_location.is_empty():
		generate_location_visited()
	if visited_location[room_name] == false:
		visited_location_queue.push_back(room_name)
		visited_location[room_name] = true
	if is_player_1:
		player_1_location = room_name
	else:
		player_2_location = room_name

func play_sound_spike(retract_sound: Node, raise_sound: Node, play_sound: bool, is_retract: bool):
	if not play_sound:
		return
	if is_retract:
		retract_sound.play()
	else:
		raise_sound.play()

func play_sound_dual(change_sound: Node, play_sound: bool):
	if play_sound:
		change_sound.play()
