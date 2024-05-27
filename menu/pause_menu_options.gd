extends Control
class_name PauseMenuOptions

@onready var pause_menu: PauseMenu = get_parent()
@onready var transition: AnimationPlayer = get_tree().get_root().find_child("Transition", true, false)

## TODO:
## Move this to PauseMenu
func _on_menu_do_item(item:Control):
	if not PlayerVar.is_paused or PlayerVar.is_pausing:
		return
	else:
		if item.name == "Resume":
			pause_menu.toggle_pause()
		elif item.name == "Restart":
			Sound.play("MenuSelect")
			pause_menu.show_confirm_restart()
			confirm_restart()
		elif item.name == "Quit":
			Sound.play("MenuSelect")
			pause_menu.show_confirm_quit()
			confirm_quit()
		elif item.name == "NoRestart":
			Sound.play("MenuCancel")
			pause_menu.hide_confirm()
			get_focus_restart()
		elif item.name == "YesRestart":
			Sound.play("MenuStart")
			Engine.time_scale = 1
			PlayerVar.is_pausing = true
			transition.play("slide_in_restart")
		elif item.name == "NoQuit":
			Sound.play("MenuCancel")
			pause_menu.hide_confirm()
			get_focus_quit()
		elif item.name == "YesQuit":
			Sound.play("MenuQuit")
			Music.pause()
			Engine.time_scale = 1
			PlayerVar.is_pausing = true
			transition.play("slide_in_quit")

func get_focus():
	$Menu.visible = true
	$ConfirmQuit.visible = false
	$ConfirmRestart.visible = false
	$Menu/Resume.grab_focus()

func get_focus_quit():
	$Menu.visible = true
	$ConfirmQuit.visible = false
	$ConfirmRestart.visible = false
	$Menu/Quit.grab_focus()

func get_focus_restart():
	$Menu.visible = true
	$ConfirmQuit.visible = false
	$ConfirmRestart.visible = false
	$Menu/Restart.grab_focus()

func confirm_quit():
	$Menu.visible = false
	$ConfirmQuit.visible = true
	$ConfirmRestart.visible = false
	$ConfirmQuit/NoQuit.grab_focus()

func confirm_restart():
	$Menu.visible = false
	$ConfirmQuit.visible = false
	$ConfirmRestart.visible = true
	$ConfirmRestart/NoRestart.grab_focus()

func exit_focus():
	$Menu/Resume.release_focus()
	$Menu/Restart.release_focus()
	$Menu/Quit.release_focus()

