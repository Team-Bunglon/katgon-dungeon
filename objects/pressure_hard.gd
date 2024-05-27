extends PressureTile

func _on_body_entered(body:Node2D):
	if "Player" in body.name:
		body_inside[body.name] = true
		if len(body_inside) > 0:
			$Sprite2D.frame = len(body_inside)
			if len(body_inside) == 2:
				RoomVar.button_states[number] = true
				for n in target_node:
					n.detect_button_presses()

func _on_body_exited(body:Node2D):
	if "Player" in body.name:
		body_inside.erase(body.name)
		$Sprite2D.frame = len(body_inside)
		RoomVar.button_states[number] = false
		for n in target_node:
			n.detect_button_presses()
