extends PlayerClass

## The bodies or tiles Kat can interact using with her alt melee attack (Shockwave)
@export var body_alt_hit: Array[String]

@onready var melee_alt_collision: CollisionShape2D = $MeleeAltHitbox/CollisionShape2D
@onready var state_alt: Variant = $AnimationTreeSW.get("parameters/playback")
@onready var camera: Camera2D = $"../Camera2D"
@onready var pause_menu: Control
@onready var has_switched: bool = false

@onready var debug: bool = false

func _input(event):
	if event.is_action_pressed("debug") and PlayerVar.debug:
		debug = not debug
		if debug: # Enable Debug
			self.collision_layer = 0
			self.collision_mask = 0
			partner.collision_mask = 0
			partner.collision_layer = 0
		else: # Disable Debug
			self.collision_layer = 1
			self.collision_mask = 1
			partner.collision_mask = 2
			partner.collision_layer = 2

func _ready():
	collision_mask_as_partner = 32
	roomd = $RoomDetector1
	partner = $"../Player2"
	attack_sound = "MeleeKat"
	alt_sound = "AltKat"
	pause_menu = get_tree().get_root().find_child("PauseMenu", true, false)
	super._ready()

## Only Kat can call switch_character function.
## Still makes sense canonically speaking since she's the one bringing Gon for adventures.
func switch_character():
	if Input.is_action_just_pressed("swap_character") and \
		not on_switch_delay and \
		not on_attack_delay and \
		not partner.on_switch_delay and \
		not partner.on_attack_delay:
		if (is_leader and can_switch) or (partner.is_leader and partner.can_switch):
			switch_procedure(true)
			leader_changed.emit(is_leader)
			on_switch_delay = true
			$SwitchDelay.start()
		elif not can_switch or not partner.can_switch:
			leader_cannot_changed.emit()	

func switch_procedure(swap_position: bool):
	change_leader()
	partner.change_leader()
	has_switched = not has_switched
	if is_follow_as_partner and partner.is_follow_as_partner:
		if swap_position:
			if has_switched:
				global_position = PlayerVar.partner_position
				partner.global_position = PlayerVar.leader_position
			else:
				global_position = PlayerVar.leader_position
				partner.global_position = PlayerVar.partner_position
	PlayerVar.switch_position() # This is useful for z_index calculation as soon as you switch leader

## This function here handle splitting action when "follow_mode" is pressed.
## The game waits for another input whether or not you want to switch character immediately after splitting.
## And yes, this code looks absolutely fucking horrendous.
func switch_follow():
	if Input.is_action_just_pressed("follow_mode") and \
		not is_splitting and \
		not on_attack_delay and \
		not on_switch_delay and \
		not is_walking and \
		is_follow_as_partner:
		is_splitting = true
		partner.is_splitting = true
		split_changed.emit(true)

	if Input.is_action_just_pressed("action_main") and is_splitting:
		if not partner.can_switch:
			cannot_split.emit()
			split_changed.emit(false)
			$SplitDelay.start()
			return		
		if not is_leader:
			switch_procedure(false)
			leader_changed_in_follow_mode_changed.emit(true)
		change_follow(false)
		partner.change_follow(false)
		split_changed.emit(false)
		$SplitDelay.start()

	if Input.is_action_just_pressed("action_alt") and is_splitting:
		if not can_switch:
			cannot_split.emit()
			split_changed.emit(false)
			$SplitDelay.start()
			return
		if is_leader:
			switch_procedure(false)
			leader_changed_in_follow_mode_changed.emit(false)
		change_follow(false)
		partner.change_follow(false)
		split_changed.emit(false)
		$SplitDelay.start()

	if Input.is_action_just_pressed("move_up") or \
		Input.is_action_just_pressed("move_down") or \
		Input.is_action_just_pressed("move_left") or \
		Input.is_action_just_pressed("move_right") or \
		Input.is_action_just_pressed("swap_character") or \
		Input.is_action_just_pressed("menu"):
		$SplitDelay.start()
		split_changed.emit(false)

func melee_alt_attack():
	if not on_attack_delay:
		state.travel("idle")
		state_alt.travel("idle")
		on_attack_delay = false
	if Input.is_action_just_pressed("action_alt") and not on_attack_delay and not is_splitting:
		Sound.play(alt_sound)
		state.travel("attack_alt")
		state_alt.travel("attack")
		camera.shake_camera()
		on_attack_delay = true
		$AttackDelay.start()

func _on_melee_hitbox_body_entered(body:Node2D):
	do_body_hit(body)

func _on_melee_alt_hitbox_body_entered(body:Node2D):
	if get_body_name(body) in body_alt_hit:
		body.hit()

func _on_pawpad_hitbox_body_entered(body:Node2D):
	if get_body_name(body) == "Pawpad":
		body.hit()

func _on_player_detector_1_body_entered(body:Node2D):
	if body.name == "Player2":
		is_partner_nearby = true
		if can_regroup and not is_follow_as_partner and not is_on_no_follow_tile and not partner.is_on_no_follow_tile:
			change_follow(true)

func _on_player_detector_1_body_exited(body:Node2D):
	if body.name == "Player2":
		is_partner_nearby = false

func _on_player_detector_1_area_exited(area:Area2D):
	if area.name == "PlayerDetector2":
		can_regroup = true
