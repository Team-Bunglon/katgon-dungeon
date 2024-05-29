extends PlayerClass

## The bodies or tiles Gon can interact with using his alt melee attack (Flameball)
@export var body_alt_hit: Array[String]

@onready var flameball_preload: Resource = preload("res://objects/flameball.tscn")

func _ready():
	collision_mask_as_partner = 576
	roomd = $RoomDetector2
	partner = $"../Player1"
	attack_sound = "MeleeGon"
	alt_sound = "AltGon"
	super._ready()

## It's not really a melee attack when you shoot fireball out of your mouth isn't it?
func melee_alt_attack():
	if not on_attack_delay:
		state.travel("idle")
	if Input.is_action_just_pressed("action_alt") and not on_attack_delay and not is_splitting:
		Sound.play(alt_sound)
		state.travel("attack_alt")
		create_flameball()
		on_attack_delay = true
		$AttackDelay.start()

func create_flameball():
	var flameball: Flameball = flameball_preload.instantiate()
	flameball.body_hit = body_alt_hit
	flameball.shoot(global_position, $FlameballDirection.position)
	get_parent().add_child(flameball)

func _on_melee_hitbox_body_entered(body:Node2D):
	do_body_hit(body)

func _on_player_detector_2_body_entered(body:Node2D):
	if body.name == "Player1":
		is_partner_nearby = true
		if can_regroup and not is_follow_as_partner and not is_on_no_follow_tile and not partner.is_on_no_follow_tile:
			change_follow(true)

func _on_player_detector_2_body_exited(body:Node2D):
	if body.name == "Player1":
		is_partner_nearby = false

func _on_player_detector_2_area_exited(area:Area2D):
	if area.name == "PlayerDetector1":
		can_regroup = true
