extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collect_sfx: AudioStreamPlayer2D = $CollectSFX


func _on_body_entered(body: Node2D) -> void:
	body.add_point()
	animated_sprite.play("collected")
	collect_sfx.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "collected":
		queue_free()
