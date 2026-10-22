extends Node2D

var cena_popup := preload("res://cenas/pop_up.tscn")

func _ready() -> void:
	if EstadoJogo.ja_viu_intro == false:
		var popup := cena_popup.instantiate()
		add_child(popup)
		popup.estabelecer_titulo("//MISSÃO DE URGÊNCIA")
		popup.estabelecer_msg("O Sistema Solar está entrando em colapso. Astros estão desaparecendo e chuvas de asteroides são mais frequentes que nunca. A você foi designada a missão de salvar a espécie humana encontrando a saída mais rápida. Pistas dessa saída estão espalhadas pelo espaço, basta navegar para encontrá-las.")
		popup.estabelecer_texto_botao("Iniciar missão")
		EstadoJogo.ja_viu_intro = true
