extends Area2D

@onready var sprite_asteroide: AnimatedSprite2D = $SpritesAsteroids
var velocidade: float
@onready var sol = get_tree().get_first_node_in_group("sol")
var direcao: Vector2
@onready var nave = get_tree().get_first_node_in_group("nave")

func _ready() -> void:
	var quadro_sorteado = randi_range(0, (sprite_asteroide.sprite_frames.get_frame_count("Asteroid") - 1))
	sprite_asteroide.set_frame(quadro_sorteado)
	
	var tamanho = randf_range(0.05, 0.1)
	scale = Vector2(tamanho, tamanho)
	rotation = randf_range(0.0, TAU)
	velocidade = randf_range(50.0, 200.0)
	direcao = (sol.position - self.position).normalized()


func _process(delta: float) -> void:
	position += direcao * velocidade * delta
	if position.distance_to(sol.position) < 2000.0 or position.distance_to(nave.position) > 1500.0:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	Audio.tocar_batida()
	nave.balancar()
	nave.receber_dano(50)
	queue_free()
