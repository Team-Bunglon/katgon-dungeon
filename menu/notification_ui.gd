extends Control
class_name NotificationUI

@export var notification_info: Dictionary = {
	   #0: ["Notififcation" , Color("FFFFFF"), "NotifSound"],
		1: ["Kat's turn!"	, Color("FF8200"), "NotifSwitchKat"],
		2: ["Gon's turn!"	, Color("0096FF"), "NotifSwitchGon"],
		3: ["Cannot Switch!", Color("FF0000"), "NotifFail"],
		4: ["Follow me!"	, Color("FFFFFF"), "NotifFollow"],
		5: ["Stay there!"	, Color("FF0000"), "NotifStay"],
		6: ["Cannot Split!"	, Color("FF0000"), "NotifFail"],
		7: ["Where's your friend?", Color("FF0000"), "NotifFail"]
}

func notif(message: int):
	$NotificationLabel.text = notification_info[message][0]
	$NotificationLabel.set("theme_override_colors/font_color", notification_info[message][1])
	$NotificationPlayer.play("show")
	Sound.play(notification_info[message][2])

func _on_player_1_leader_changed(leader_status:bool):
	if leader_status:
		notif(1)
	else:
		notif(2)

func _on_player_1_leader_cannot_changed():
	notif(3)

func _on_player_1_follow_mode_changed(follow_status:bool):
	if follow_status:
		notif(4)
	else:
		notif(5)

func _on_player_1_cannot_split():
	notif(6)

func _on_dragon_fruit_on_collected(collect_status:bool):
	if not collect_status:
		notif(7)


