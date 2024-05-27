extends Control

@onready var can_select: bool = false
signal press_start(is_start: bool)

func _on_menu_do_item(item:Control):
	if can_select:
		can_select = false
		if item.name == "Start":
			press_start.emit(true)
		elif item.name == "Quit":
			press_start.emit(false)
		item.release_focus()

func get_focus():
	$"Menu/Start".grab_focus()
