extends Node

@export var mob_scene : PackedScene

func _on_mob_timer_timeout() -> void:
	var mob : Mob = mob_scene.instantiate()
	var mob_spawn_location : PathFollow3D = get_node("SpawnPath/SpawnLocation")
	var player_position : Vector3 = $Player.position
	
	mob_spawn_location.progress_ratio = randf()
	mob.initialize(mob_spawn_location.position, player_position)
	
	add_child(mob)
