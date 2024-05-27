extends RoomClass

func _on_spike_153_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractSound, $RaiseSound, play_sound, is_retract)

func _on_spike_152_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractSound, $RaiseSound, play_sound, is_retract)

func _on_spike_151_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractSound, $RaiseSound, play_sound, is_retract)

