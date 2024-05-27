extends Node2D

@onready var is_playing: bool = false

## Play Dungeon Music. Stop Menu Music if playing.
func dungeon_play():
	if not is_playing:
		$DungeonMusic.volume_db = 0
		$DungeonMusic.play()
		is_playing = true

## Stop Dungeon Music
func dungeon_stop():
	is_playing = false
	var music_tween = create_tween()
	music_tween.tween_property($DungeonMusic, "volume_db", -80, 3)
	await music_tween.finished
	music_tween.kill()
	$DungeonMusic.stop()

## Play Menu Music. Stop Dungeon Music if playing.
func menu_play():
	if not is_playing:
		$MenuMusic.volume_db = 0
		$MenuMusic.play()
		is_playing = true

## Stop Menu Music
func menu_stop():
	is_playing = false
	var music_tween = create_tween()
	music_tween.tween_property($MenuMusic, "volume_db", -80, 3)
	await music_tween.finished
	music_tween.kill()
	$MenuMusic.stop()

