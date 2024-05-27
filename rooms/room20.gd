extends RoomClass

func _on_spike_frostfire_201_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractFlameSound, $RaiseFlameSound, play_sound, is_retract)

func _on_spike_flame_201_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractFlameSound, $RaiseFlameSound, play_sound, is_retract)

