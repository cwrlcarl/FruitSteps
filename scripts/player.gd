extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -700.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var run_sfx: AudioStreamPlayer2D = $RunSFX
@onready var hit_sfx: AudioStreamPlayer2D = $HitSFX
@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var die_sfx: AudioStreamPlayer2D = $DieSFX

var alive := true

func _physics_process(delta: float) -> void:
	if not alive:
		velocity += get_gravity() * delta
		rotation -= 2 * delta
		move_and_slide()
		return
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()

	var direction := Input.get_axis("left", "right")
	
	if is_on_floor():
		if direction != 0:
			animated_sprite.play("run")
			if not run_sfx.playing:
				run_sfx.play()
		else:
			animated_sprite.play("idle")
			run_sfx.stop()
	elif velocity.y < 0:
		animated_sprite.play("jump")
	else:
		animated_sprite.play("fall")
	
	if direction == -1:
		animated_sprite.flip_h = true
	elif direction == 1:
		animated_sprite.flip_h = false
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func die() -> void:
	alive = false
	animated_sprite.play("hit")
	collision_shape.set_deferred("disabled", true)
	velocity.y = -500
	velocity.x = -200
	hit_sfx.play()
	die_sfx.play()
	
	
func add_point() -> void:
	print("+1 Fruit!")
	
	
func finish() -> void:
	print("Finished!")

	
	
	
	
	
	
	
