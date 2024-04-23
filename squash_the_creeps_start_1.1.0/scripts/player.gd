extends CharacterBody3D
class_name Player

@export var speed : int = 14
@export var fall_acceleration : int = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var target_velocity : Vector3 = Vector3.ZERO

func _physics_process(delta : float) -> void:
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	elif Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		
		if collision.get_collider() == null:
			continue
		
		if collision.get_collider().is_in_group("mob"):
			var mob : Mob = collision.get_collider()
			
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash()
				target_velocity.y = bounce_impulse
				break
	
	velocity = target_velocity
	
	move_and_slide()
