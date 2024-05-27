extends RoomClass

func _on_serious_table_666_state_changed(play_sound:bool, is_retract:bool):
	if play_sound and is_retract:
		$SecretSound.play()
	elif play_sound and not is_retract:
		$SecretSound.stop()

