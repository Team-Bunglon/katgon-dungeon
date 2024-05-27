extends Control
class_name Map

func generate_map():
	if not RoomVar.visited_location_queue.is_empty():
		for room in RoomVar.visited_location_queue:
			reveal_map(room)
		RoomVar.visited_location_queue = []
	if RoomVar.player_1_location == RoomVar.player_2_location:
		var map_shade = get_node(room_to_cover(RoomVar.player_1_location))
		$Player1Location.visible = false
		$Player2Location.visible = false
		$Player12Location.visible = true
		$Player12Location.position = map_shade.position
	else:
		var map_shade_1 = get_node(room_to_cover(RoomVar.player_1_location))
		var map_shade_2 = get_node(room_to_cover(RoomVar.player_2_location))
		$Player1Location.visible = true
		$Player2Location.visible = true
		$Player12Location.visible = false
		$Player1Location.position = map_shade_1.position
		$Player2Location.position = map_shade_2.position

func reveal_map(room_name: String):
	var map_shade: Sprite2D = get_node(room_to_cover(room_name))
	map_shade.visible = false
		
func room_to_cover(room: String):
	return "MapCover#" + str(room.get_slice("#", 1))
