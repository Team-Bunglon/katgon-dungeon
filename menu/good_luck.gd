extends Node2D

@onready var can_select: bool = false

func _ready():
	$TextPlayer.play("default")
	$TransitionFade.play("fade_out")

func _input(event):
	if event.is_action_pressed("action_main") and can_select:
		MusicVar.menu_stop()
		$TransitionFade.play("fade_in")

func _on_transition_fade_animation_finished(anim_name:StringName):
	if anim_name == "fade_out":
		can_select = true
	elif anim_name == "fade_in":
		get_tree().change_scene_to_file("res://rooms/main_dungeon.tscn")

