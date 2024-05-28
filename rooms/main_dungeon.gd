extends Node2D

@onready var mm_screen	:= "res://menu/main_menu.tscn"
@onready var win_screen := "res://menu/win_screen.tscn"

func _ready():
	PlayerVar.load_stuff()
	RoomVar.load_stuff()
	Music.play("Dungeon", false)
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
		get_tree().change_scene_to_file(mm_screen)
	elif anim_name == "slide_in":
		get_tree().change_scene_to_file(win_screen)

