extends RoomClass


func _on_spike_244_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractSound, $RaiseSound, play_sound, is_retract)

func _on_spike_241_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractSound, $RaiseSound, play_sound, is_retract)

func _on_spike_frostfire_241_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractFlameSound, $RaiseFlameSound, play_sound, is_retract)

