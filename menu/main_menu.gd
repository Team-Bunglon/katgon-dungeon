extends Control
class_name MainMenu

func _ready():
	Music.play("Menu")
	$Version.text = $Version.text + ProjectSettings.get_setting("application/config/version")
	$MainMenuOptions.can_select = false
	$Background.play("default")
	$Logo.play("default")
	$Transition.play("slide_out")

func _on_transition_animation_finished(anim_name:StringName):
	if anim_name == "slide_in":
		get_tree().change_scene_to_file("res://menu/good_luck.tscn")
	elif anim_name == "slide_out":
		$MainMenuOptions.get_focus()
	elif anim_name == "slide_in_quit":
		get_tree().quit()

func _on_main_menu_options_start():
	$Transition.play("slide_in")

func _on_main_menu_options_options():
	$MainMenuOptions.get_focus()

func _on_main_menu_options_quit():
	$Transition.play("slide_in_quit")
