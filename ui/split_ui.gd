extends Control

func _on_player_1_split_changed(split_status:bool):
	if split_status:
		show()
	else:
		hide()

