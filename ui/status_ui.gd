extends Control

func _on_player_1_leader_changed(leader_status:bool):
	if leader_status:
		$Leader.frame = 2
	else:
		$Leader.frame = 3

func _on_player_1_follow_mode_changed(follow_status:bool):
	if follow_status:
		$Status.frame = 4
	else:
		$Status.frame = 5 

func _on_player_1_leader_changed_in_follow_mode_changed(leader_status:bool):
	_on_player_1_leader_changed(leader_status)

