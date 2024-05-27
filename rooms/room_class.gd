extends Node2D
class_name RoomClass

@export var room_name: String = "Sample Room Name"

func _ready():
	RoomVar.room_count += 1
