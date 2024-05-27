extends Control

@onready var can_select: bool = false
signal press_start(is_start: bool)
signal start()
signal options()
signal quit()

func _on_menu_do_item(item:Control):
	if can_select:
		can_select = false
		if item.name == "Start":
			Sound.play("MenuStart")
			start.emit()
		elif item.name == "Options":
			Sound.play("MenuSelect")
			options.emit()
		elif item.name == "Quit":
			Sound.play("MenuQuit")
			quit.emit()
		item.release_focus()

func get_focus():
	$"Menu/Start".grab_focus()
	can_select = true
