extends Node


var vidas: int = 5
var monedas: int = 0
var monedas_agarradas: int = 0
var puntaje: int = 0
var puntaje_total: int = 0
var nivel_actual = ""
var nivel_siguiente = ""
var num_nivel_actual: int = 0
var cargando_partida: bool


func _ready() -> void:
# warning-ignore:return_value_discarded
	Eventos.connect("game_over", self, "_on_game_over")


func resetear() -> void:
	vidas = 5
	puntaje = 0
	restar_monedas_agarradas()


func reseteo_completo() -> void:
	resetear()
	puntaje_total = 0


func obtener_puntaje() -> int:
	var valor_moneda = monedas * 5
	puntaje = valor_moneda
	puntaje_total += puntaje
	
	return puntaje


func restar_vida() -> void:
	vidas -= 1
	restar_monedas_agarradas()
	
	if vidas == 0:
		Eventos.emit_signal("game_over")
	
	Eventos.emit_signal("actualizar_datos_hud")


func obtener_moneda() -> void:
	monedas += 1
	monedas_agarradas += 1
	Eventos.emit_signal("actualizar_datos_hud")


func restar_monedas_agarradas() -> void:
	monedas -= monedas_agarradas
	resetear_monedas_agarradas()


func resetear_monedas_agarradas() -> void:
	monedas_agarradas = 0


func _on_game_over() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://juego/Menus/MenuGameOver.tscn")
