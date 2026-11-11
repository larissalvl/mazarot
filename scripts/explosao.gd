extends Node2D

func _ready() -> void:
	$SpritesExplosao.play("explosao")
	Audio.tocar_explosao()

func _on_sprites_explosao_animation_finished() -> void:
	queue_free()
