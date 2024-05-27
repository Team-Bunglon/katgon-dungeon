extends RoomClass

func _on_spike_dual_2201_state_changed_dual(play_sound:bool):
	RoomVar.play_sound_dual($DualSound, play_sound)

func _on_spike_2220_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractSound, $RaiseSound, play_sound, is_retract)

func _on_spike_frostfire_600_state_changed(play_sound:bool, is_retract:bool):
	RoomVar.play_sound_spike($RetractFlameSound, $RaiseFlameSound, play_sound, is_retract)

