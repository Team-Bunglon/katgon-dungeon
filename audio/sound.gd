extends Node
class_name SoundVar

## Play a sound effect. Do NOT play music using this, use Music.music_play().
func play(sound_name: String) -> void:
	var sound := _get_sound(sound_name)
	if sound != null: sound.playing = true

func stop(sound_name: String) -> void:
	var sound := _get_sound(sound_name)
	if sound != null: sound.playing = false

func _get_sound(sound_name: String) -> AudioStreamPlayer:
	var sound: AudioStreamPlayer = get_node_or_null(sound_name)
	if sound == null: print(sound_name + " not found")
	return sound
