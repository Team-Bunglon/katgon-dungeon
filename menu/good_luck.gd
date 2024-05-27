extends Control
class_name GoodLuck

func _ready():
	$TransitionFade.play("fade_out")

func _input(event):
	if event.is_action_pressed("ui_accept") and not $TransitionFade.is_playing():
		Music.pause()
		Sound.play("MenuSelect")
		$TransitionFade.play("fade_in")

func _on_transition_fade_animation_finished(anim_name:StringName):
	if anim_name == "fade_in":
		get_tree().change_scene_to_file("res://rooms/main_dungeon.tscn")
	elif anim_name == "fade_out":
		$TextPlayer.play("default")

