extends Area2D

var vel_bala = 750

func _ready() -> void:
	$SpritesBalas.play("bala")
	Audio.tocar_tiro()


func _process(delta: float) -> void:
	position += Vector2.UP.rotated(rotation) * vel_bala * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_sprites_balas_animation_finished() -> void:
	queue_free()
