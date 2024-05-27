extends Node2D

func _ready():
	MusicVar.menu_play()
	$Background.play("default")
	$Logo.play("default")
	$MainMenuOptions.get_focus()
	$Transition.play("slide_out")

func _on_main_menu_options_press_start(is_start: bool):
	if is_start:
		$SelectSound.play()
		$Transition.play("slide_in")
	else:
		$QuitSound.play()
		$Transition.play("slide_in_quit")

func _on_transition_animation_finished(anim_name:StringName):
	if anim_name == "slide_in":
		get_tree().change_scene_to_file("res://menu/good_luck.tscn")
	elif anim_name == "slide_out":
		$MainMenuOptions.can_select = true
	elif anim_name == "slide_in_quit":
		get_tree().quit()
