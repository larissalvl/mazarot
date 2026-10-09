extends CanvasLayer

@onready var barra_vida = $barraVida
@onready var nave = get_tree().get_first_node_in_group("jogador")

func _ready():
	atualizar_vida()
	nave.vida_mudou.connect(atualizar_vida)

func atualizar_vida():
	barra_vida.max_value = nave.vida_maxima
	barra_vida.value = nave.vida_atual
