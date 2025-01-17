extends Node
class_name MusicVar

# Codebase taken from Phantom Striker 
@export var fade_duration: float = 2.0 ## The duration of which the music would cross fade
@export var pause_duration: float = 0.5 ## The duration of which the music would fade pause

# These two variables should be null on start
@onready var music_node: AudioStreamPlayer
@onready var music_prev: AudioStreamPlayer
@onready var default_db: Dictionary = {}

func play(music_name: String, is_fading = true):
	var fade_out_tween := create_tween()
	var fade_in_tween := create_tween()
	fade_out_tween.finished.connect(_on_music_faded)

	# During the start of the game when the first music is played
	if music_node == null:
		music_node = _get_music(music_name)
		music_node.playing = true

	# During mid game when music is changed
	elif music_node != null:
		if music_node.get_name() == music_name:
			music_node.volume_db = default_db[music_node.name]
			music_node.stream_paused = false
			return
		music_prev = music_node
		music_node = _get_music(music_name)
		if is_fading:
			music_node.volume_db = -INF
			music_node.playing = true
			fade_out_tween.tween_method(_change_music_prev_volume, 1.0, 0.0, fade_duration)
			fade_in_tween.tween_method(_change_music_node_volume, 0.0, 1.0, fade_duration)
		else:
			music_node.volume_db = default_db[music_node.name]
			music_prev.volume_db = default_db[music_prev.name]
			music_node.playing = true
			music_prev.playing = false

## Pause the currently played music, use music_play().
func pause(is_fading = true):
	if music_node == null:
		return

	var fade_out_tween := create_tween()
	fade_out_tween.finished.connect(_on_music_paused)

	if is_fading:
		fade_out_tween.tween_method(_change_music_node_volume, 1.0, 0.0, pause_duration)
	else:
		music_node.stream_paused = true

## If you need to get the currently playing music for some reason, use this.
func get_current_music():
	return music_node

func _change_music_node_volume(value: float):
	music_node.volume_db = linear_to_db(value) + default_db[music_node.name]

func _change_music_prev_volume(value: float):
	music_prev.volume_db = linear_to_db(value) + default_db[music_prev.name]

func _get_music(music_name: String) -> AudioStreamPlayer:
	var new_music_node := get_node(music_name)
	if not default_db.has(music_name):
		default_db[music_name] = new_music_node.volume_db
	return new_music_node

func _on_music_faded():
	music_node.stream_paused = false
	music_prev.playing = false

func _on_music_paused():
	music_node.stream_paused = true
