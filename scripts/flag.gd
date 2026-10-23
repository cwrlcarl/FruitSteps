extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $"../Label"
@onready var win_sfx: AudioStreamPlayer2D = $WinSFX

var finish := false


func _on_body_entered(body: Node2D) -> void:
	if not finish and get_tree().get_nodes_in_group("fruits").size() == 0:
		body.finish()
		animated_sprite.play("flag out")
		# get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "flag out":
		animated_sprite.play("idle")
		finish = true
