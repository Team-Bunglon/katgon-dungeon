extends Control
class_name Credit

func _ready():
	$Background.play("default")
	$Continue.visible = false
	$Transition.play("slide_out")

func _input(event):
	if event.is_action_pressed("ui_accept") and not $Transition.is_playing():
		Sound.play("MenuQuit")
		$Transition.play("slide_in")

func _on_transition_animation_finished(anim_name:StringName):
	if anim_name == "slide_in":
		get_tree().change_scene_to_file("res://menu/main_menu.tscn")
	elif anim_name == "slide_out":
		$TextPlayer.play("default")
