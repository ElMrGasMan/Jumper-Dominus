extends Node


var vidas: int = 3
var monedas: int = 0
var puntaje: int = 0
var nivel_actual = ""
var nivel_siguiente = ""
var num_nivel_actual: int = 0

func resetear() -> void:
	vidas = 3
	monedas = 0
	puntaje = 0


func obtener_puntaje() -> int:
	var valor_moneda = monedas * 5
	puntaje = valor_moneda
	
	return puntaje


func restar_vida() -> void:
	vidas -= 1
	
	if vidas == 0:
		Eventos.emit_signal("game_over")
	
	Eventos.emit_signal("actualizar_datos_hud")


func obtener_moneda() -> void:
	monedas += 1
	Eventos.emit_signal("actualizar_datos_hud")
