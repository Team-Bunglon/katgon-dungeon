extends RoomClass

func _on_spike_420_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractSound, $RaiseSound, play_sound, is_retract)
	RoomVar.play_sound_spike($RetractFlameSound, $RaiseFlameSound, play_sound, is_retract)
	RoomVar.play_sound_dual($RaiseSound, play_sound)

