extends RoomClass

func _on_spike_dual_191_state_changed_dual(play_sound:bool):
	RoomVar.play_sound_dual($RaiseSound, play_sound)

