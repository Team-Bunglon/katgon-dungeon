extends Control
class_name ObtainUI

func _ready():
	visible = false

## Show golden cherry obtain message briefly
func show_obtain():
	$AnimationPlayer.play("show")
