extends Area2D

@onready var sprite_asteroide: AnimatedSprite2D = $SpritesAsteroids
var velocidade: float
var direcao: Vector2
@onready var tamanho = randf_range(0.05, 0.2)

var cena_explosao_asteroide = preload("res://cenas/explosao_asteroide.tscn")

@onready var sol = get_tree().get_first_node_in_group("sol")
@onready var nave = get_tree().get_first_node_in_group("nave")

var atingido := false

func _ready() -> void:
	var quadro_sorteado = randi_range(0, (sprite_asteroide.sprite_frames.get_frame_count("Asteroid") - 1))
	sprite_asteroide.set_frame(quadro_sorteado)
	
	scale = Vector2(tamanho, tamanho)
	rotation = randf_range(0.0, TAU)
	velocidade = randf_range(50.0, 200.0)
	direcao = (sol.position - self.position).normalized()


func _process(delta: float) -> void:
	position += direcao * velocidade * delta
	if position.distance_to(sol.position) < 2000.0 or position.distance_to(nave.position) > 1500.0:
		queue_free()


func _on_body_entered(_body: Node2D) -> void:
	Audio.tocar_batida()
	nave.balancar()
	nave.receber_dano(50)
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("balas"):
		if atingido == true:
			area.queue_free()
			return
		else:
			atingido = true
			var explosao_asteroide = cena_explosao_asteroide.instantiate()
			get_tree().current_scene.add_child(explosao_asteroide)
			explosao_asteroide.global_position = global_position
			var tamanho_explosao = tamanho * 8
			explosao_asteroide.scale = Vector2(tamanho_explosao, tamanho_explosao)
			Audio.tocar_explosao_asteroide()
			area.queue_free()
			queue_free()
