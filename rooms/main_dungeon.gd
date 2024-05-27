extends Node2D

func _ready():
	PlayerVar.load_stuff()
	RoomVar.load_stuff()
	MusicVar.dungeon_play()
	$CanvasLayer/Transition.play("slide_out")

func _on_room_logger_1_area_entered(area:Area2D):
	var room_name = area.get_parent().name
	if "Room" in room_name:
		RoomVar.update_visited_location(room_name, true)

func _on_room_logger_2_area_entered(area:Area2D):
	var room_name = area.get_parent().name
	if "Room" in room_name:
		RoomVar.update_visited_location(room_name, false)

func _on_transition_animation_finished(anim_name):
	if anim_name == "slide_in_restart":
		get_tree().reload_current_scene()
	elif anim_name == "slide_in_quit":
		get_tree().quit()
