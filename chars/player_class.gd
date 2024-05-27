## The base player class this project uses specifically for our two partners :3
class_name PlayerClass extends CharacterBody2D

## Can the character be played by the player?
## Make sure the other character has the opposite is_leader boolean.
@export var is_leader: bool = true

## Walking speed, of course. What else this variable would be? 
@export var speed: int = 400 

## How many frames the walking state will linger after the character
## as the partner has stopped moving before switching to idle state.
@export var linger: int = 5 

## The direction the character will look at when the game starts
@export var direction_start: Vector2 = Vector2(0, 1)

## The bodies or tiles the character can interact using their main melee attack
@export var body_hit: Array[String]

## The tiles that prevent a character to switch to other character when they are stepping on it.
@export var bad_tiles: Array[String] = ["Spike", "SpikeExact"]

## Automatically turn off follow mode when a character steps inside this tiles
@export var no_follow_tiles: Array[String]

# Assigning nodes as variable
@onready var anim: AnimationTree = $AnimationTree
@onready var state: Variant = anim.get("parameters/playback")
@onready var idle:String = "parameters/idle/blend_position"
@onready var move: String = "parameters/move/blend_position"
@onready var attack: String = "parameters/attack/blend_position"
@onready var attack_alt: String = "parameters/attack_alt/blend_position"

# Assign this at the child class
@onready var roomd: Area2D
@onready var partner: PlayerClass

# Frame linger for walking to idle animation
@onready var linger_current: int = 0

# Booleans
@onready var collision_mask_as_leader : int = collision_mask
@onready var collision_mask_as_partner: int = 32
@onready var can_switch: bool = true
@onready var can_regroup: bool = true
@onready var on_switch_delay: bool = false
@onready var on_attack_delay: bool = false
@onready var is_walking: bool = false
@onready var is_splitting: bool = false
@onready var is_partner_nearby: bool = true
@onready var is_follow_as_partner: bool = true
@onready var is_on_no_follow_tile: bool = false
@onready var bad_tiles_current: Dictionary
@onready var no_follow_tiles_current: Dictionary

# Signal for notification
## Emitted when the character changed their leader status.
signal leader_changed(leader_status: bool)

## Emitted when the character cannot change their leader status.
signal leader_cannot_changed()

## Emitted when the follow mode has changed
signal follow_mode_changed(follow_status: bool)

## Emitted when splitting action is performed
signal split_changed(split_status: bool)

## Emitted when the duo cannot split
signal cannot_split()

## Emitted when pause button is pressed
signal pause_signal()

## Emitted when the cheat input is detected
signal do_cheat(enable: bool)

func _ready():
	anim.set(move, direction_start)
	anim.set(idle, direction_start)
	anim.set(attack, direction_start)
	anim.set(attack_alt, direction_start)
	if is_leader:
		PlayerVar.leader_position = global_position
	else:
		PlayerVar.partner_position = global_position
		collision_mask = collision_mask_as_partner
		z_index = 10
	
func _physics_process(_delta):
	if not PlayerVar.game_run:
		state.travel("idle")
		return 

	if not PlayerVar.is_paused:
		if is_leader:
			if not is_splitting:
				melee_attack()
				melee_alt_attack()
			if not on_attack_delay:
				move_as_leader()
			PlayerVar.leader_position = global_position
		else:
			if is_follow_as_partner:
				move_as_partner()
			PlayerVar.partner_position = global_position
		switch_character()
		switch_follow()

	if Input.is_action_just_pressed("menu"):
		state.travel("idle")
		pause_signal.emit()

	if PlayerVar.get_distance() >= 120 and is_follow_as_partner:
		change_follow(false)

# Only Kat can call switch_character and switch_follow function.
func switch_character():
	pass

func switch_follow():
	if Input.is_action_just_pressed("follow_mode") and \
		not is_splitting and \
		not on_attack_delay and \
		not on_switch_delay and \
		not is_walking and \
		is_follow_as_partner:
		is_splitting = true

	if Input.is_action_just_pressed("action_main") and is_splitting:
		is_splitting = false

	if Input.is_action_just_pressed("action_alt") and is_splitting:
		is_splitting = false

	if Input.is_action_just_pressed("move_up") or \
		Input.is_action_just_pressed("move_down") or \
		Input.is_action_just_pressed("move_left") or \
		Input.is_action_just_pressed("move_right") or \
		Input.is_action_just_pressed("swap_character") or \
		Input.is_action_just_pressed("menu"):
		is_splitting = false
	pass

func change_leader():
	is_leader = not is_leader
	roomd.monitoring = not roomd.monitoring
	roomd.monitorable = not roomd.monitorable
	if is_leader:
		collision_mask = collision_mask_as_leader
		update_z()
	else:
		collision_mask = collision_mask_as_partner
		if not is_follow_as_partner:
			state.travel("idle")
		z_index = 10

func change_follow(to_bool: bool):
	is_follow_as_partner = to_bool
	can_regroup = to_bool
	if not is_follow_as_partner and not is_leader:
		state.travel("idle")
	on_switch_delay = true
	$SwitchDelay.start()
	follow_mode_changed.emit(to_bool)

## You don't attack anything actually. You are just interacting with the room objects.
func melee_attack():
	if not on_attack_delay:
		state.travel("idle")
	if Input.is_action_just_pressed("action_main") and not on_attack_delay:
		state.travel("attack")
		on_attack_delay = true
		$AttackDelay.start()

## Please override this function in your child class thank you
func melee_alt_attack():
	pass

func move_as_leader():
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"),
	)
	if not (direction.x == 0 or direction.y == 0):
		direction /= sqrt(2)
	update_movement(direction)
	update_z()

func move_as_partner():
	if global_position.distance_to(PlayerVar.leader_position) > 60:
		var direction = global_position.direction_to(PlayerVar.leader_position)
		update_movement(direction)
		linger_current = linger
	else:
		if linger_current > 0:
			linger_current -= 1
		elif linger_current <= 0:
			update_anim(Vector2.ZERO)
	pass

func update_movement(direction: Vector2):
	velocity = direction * speed
	update_anim(direction)
	move_and_slide()
	return velocity

func update_anim(direction: Vector2):
	if direction != Vector2.ZERO:
		is_walking = true
		state.travel("move")
		anim.set(move, direction)
		anim.set(idle, direction)
		anim.set(attack, direction)
		anim.set(attack_alt, direction)
	elif not Input.is_action_pressed("action_main"):
		is_walking = false
		state.travel("idle")

func update_z():
	if global_position.y >= PlayerVar.partner_position.y:
		z_index = 15
	else:
		z_index = 5

### Function for signals
func get_body_name(body:Node2D):
	return body.name.get_slice("#", 0)

func do_body_hit(body:Node2D):
	if get_body_name(body) in body_hit:
		body.hit()

func detect_bad_tiles(body:Node2D, is_entering:bool):
	var tile = get_body_name(body)
	if tile in bad_tiles:
		if is_entering: #entering
			bad_tiles_current[tile] = true
			can_switch = false
			print(bad_tiles_current, can_switch)
		else: 
			bad_tiles_current.erase(tile)
			if bad_tiles_current.is_empty():
				can_switch = true
			print(bad_tiles_current, can_switch)

func detect_no_follow_tiles(body:Node2D, is_entering:bool):
	var tile = get_body_name(body)
	if tile in no_follow_tiles:
		if is_entering:
			no_follow_tiles_current[body.name] = true
			is_on_no_follow_tile = true
			if is_follow_as_partner and body.is_raised:
				change_follow(false)
				partner.change_follow(false)
				partner.state.travel("idle")
		else:
			no_follow_tiles_current.erase(body.name)
			if no_follow_tiles_current.is_empty():
				is_on_no_follow_tile = false
				if is_partner_nearby and not is_follow_as_partner:
					change_follow(true)
					partner.change_follow(true)
