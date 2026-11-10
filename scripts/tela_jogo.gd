extends Node2D

var molde_cena_popup := preload("res://cenas/pop_up.tscn")
var molde_asteroide := preload("res://cenas/asteroids.tscn")

func _ready() -> void:
	if EstadoJogo.ja_viu_intro == false:
		var popup := molde_cena_popup.instantiate()
		add_child(popup)
		popup.estabelecer_titulo("//MISSÃO DE URGÊNCIA")
		popup.estabelecer_msg("O Sistema Solar está entrando em colapso. Astros estão desaparecendo e chuvas de asteroides são mais frequentes que nunca. A você foi designada a missão de salvar a espécie humana encontrando a saída mais rápida. Pistas dessa saída estão espalhadas pelo espaço, basta navegar para encontrá-las.")
		popup.estabelecer_texto_botao("Iniciar missão")
		EstadoJogo.ja_viu_intro = true

func criar_asteroide():
	var asteroide = molde_asteroide.instantiate()
	var angulo = randf_range(0.0, TAU)
	var direcao = Vector2.from_angle(angulo)
	var raio = 700.0
	var nave = get_tree().get_first_node_in_group("jogador")

	asteroide.position = nave.position + direcao * raio	
	
	add_child(asteroide)

func _on_timer_timeout() -> void:
	criar_asteroide()
