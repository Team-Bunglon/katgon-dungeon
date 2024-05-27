extends VBoxContainer
class_name Menu

# Codebase provided by Nathan Hoad
# https://youtu.be/p_m3xgWAFo0
signal do_item(item: Control)
@export var pointer: Node

func _ready():
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	get_menu()

func _unhandled_input(event):
	if not visible:
		return
	get_viewport().set_input_as_handled()
	var item = get_viewport().gui_get_focus_owner()
	if is_instance_valid(item) and event.is_action_pressed("ui_accept"):
		do_item.emit(item)

func get_items() -> Array[Control]:
	var items: Array[Control] = []
	for item in get_children():
		if not item is Control:
			continue
		items.append(item)
	return items

func get_menu():
	var items: Array[Control] = get_items()
	for i in len(items):
		var item: Control = items[i]
		item.focus_mode = Control.FOCUS_ALL

		item.focus_neighbor_left = item.get_path()
		item.focus_neighbor_right = item.get_path()

		# Get the previous item from the list (or top)
		if i == 0:
			item.focus_neighbor_top = items[len(items)-1].get_path()
			item.focus_previous = items[len(items)-1].get_path()
			item.grab_focus()
		else:
			item.focus_neighbor_top = items[i-1].get_path()
			item.focus_previous = items[i-1].get_path()

		# Get the next item from the list (or bottom)
		if i == len(items) - 1:
			item.focus_neighbor_bottom = items[0].get_path()
			item.focus_next = items[0].get_path()
		else:
			item.focus_neighbor_bottom = items[i+1].get_path()
			item.focus_next = items[i+1].get_path()

func get_focused_item():
	var item = get_viewport().gui_get_focus_owner()
	if item in get_children():
		return item  
	else:
		return null

func update_selection():
	var item = get_focused_item()

	if is_instance_valid(item) and is_instance_valid(pointer) and visible:
		pointer.global_position = Vector2(global_position.x - 60 , item.global_position.y + item.size.y * 3.5)

func _on_focus_changed(item: Control):
	if not item:
		return
	if not item in get_children():
		return
	update_selection()

