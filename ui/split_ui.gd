extends Control

@onready var notif: NotificationUI = $"../NotificationUI"

func _on_player_1_split_changed(split_status:bool):
	if split_status:
		show()
		notif.hide()
		Sound.play("Split")
	else:
		hide()

