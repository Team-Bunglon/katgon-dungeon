extends Control
class_name MainMenu

@onready var can_skip := false

func _ready():
	$Version.text = $Version.text + ProjectSettings.get_setting("application/config/version")
	$MainMenuOptions.can_select = false
	$Background.play("default")
	$Logo.play("default")
	$Transition.play("slideshow1")

func _input(event):
	if event.is_action_pressed("ui_accept") and $Transition.is_playing():
		$Transition.stop()
		_show_main_menu()

func _show_main_menu():
	Music.play("Menu")
	$Transition/Slide1.visible = false
	$Transition/Slide2.visible = false
	$Transition/Slide3.visible = false
	$BG.visible = false
	$MainMenuOptions.visible = true
	$Transition.play("slide_out")

func _on_transition_animation_finished(anim_name:StringName):
	if anim_name == "slide_in":
		get_tree().change_scene_to_file("res://menu/good_luck.tscn")
	elif anim_name == "slide_out":
		$MainMenuOptions.get_focus()
	elif anim_name == "slide_in_quit":
		get_tree().quit()
	elif anim_name == "slideshow1":
		$Transition.play("slideshow2")
	elif anim_name == "slideshow2":
		$Transition.play("slideshow3")
	elif anim_name == "slideshow3":
		$Transition.play("slideshow4")
	elif anim_name == "slideshow4":
		_show_main_menu()

func _on_main_menu_options_start():
	$Transition.play("slide_in")

func _on_main_menu_options_options():
	$MainMenuOptions.get_focus()

func _on_main_menu_options_quit():
	$Transition.play("slide_in_quit")
