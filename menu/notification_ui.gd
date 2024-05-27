extends Control

@export var notification_text: Dictionary = {
		1: ["Kat's turn!", Color("FF8200")],
		2: ["Gon's turn!", Color("0096FF")],
		3: ["Cannot Switch!", Color("FF0000")],
		4: ["Follow me!", Color("FFFFFF")],
		5: ["Stay there!", Color("FF0000")],
		6: ["Cannot Split!", Color("FF0000")],
		7: ["Where's your friend?", Color("FF0000")]
}


func notif(message: int):
	$NotificationLabel.text = notification_text[message][0]
	$NotificationLabel.set("theme_override_colors/font_color", notification_text[message][1])
	$NotificationPlayer.play("show")

func _on_player_1_leader_changed(leader_status:bool):
	if leader_status:
		$SwitchToKatSound.play()
		notif(1)
	else:
		$SwitchToGonSound.play()
		notif(2)

func _on_player_1_leader_cannot_changed():
	$CantSwitchSound.play()
	notif(3)

func _on_player_1_follow_mode_changed(follow_status:bool):
	if follow_status:
		$FollowMeSound.play()
		notif(4)
	else:
		$StayThereSound.play()
		notif(5)

func _on_player_1_cannot_split():
	$CantSwitchSound.play()
	notif(6)

func _on_dragon_fruit_on_collected(collect_status:bool):
	if not collect_status:
		$CantSwitchSound.play()
		notif(7)


