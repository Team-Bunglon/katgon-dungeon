extends Destructible

func _on_animation_tree_animation_finished(anim_name:StringName):
	if anim_name == "destroyed":
		queue_free()

