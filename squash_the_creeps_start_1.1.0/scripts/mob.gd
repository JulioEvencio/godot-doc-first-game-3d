extends CharacterBody3D
class_name Mob

signal squashed

@export var min_speed : int = 10
@export var max_speed : int = 18

func _physics_process(_delta : float) -> void:
	move_and_slide()

func initialize(start_position : Vector3, player_position : Vector3) -> void:
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	var random_speed : int = randi_range(min_speed, max_speed)
	
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func squash() -> void:
	squashed.emit()
	queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
