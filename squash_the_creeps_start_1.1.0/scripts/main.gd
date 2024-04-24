extends Node

@export var mob_scene : PackedScene

func _ready() -> void:
	$UserInterface/Retry.hide()

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()

func _on_mob_timer_timeout() -> void:
	var mob : Mob = mob_scene.instantiate()
	var mob_spawn_location : PathFollow3D = get_node("SpawnPath/SpawnLocation")
	var player_position : Vector3 = $Player.position
	
	mob_spawn_location.progress_ratio = randf()
	mob.initialize(mob_spawn_location.position, player_position)
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())
	
	add_child(mob)

func _on_player_hit() -> void:
	$MobTimer.stop()
	$UserInterface/Retry.show()
