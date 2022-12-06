class_name Nivel
tool
extends Node


export(String, FILE, "*.tscn") var siguiente_nivel = ""
export var numero_nivel: int = 0

onready var timer: Timer = $CosasExtra/Timer
onready var advertencia: Label = $CosasExtra/AdvertenciaGuardado


func _ready() -> void:
	MusicaStellarRaiders.ejecutar_musica(MusicaStellarRaiders.get_mus_amb())
	DataDelJugador.resetear_monedas_agarradas()
	timer.start()
	advertencia.visible = true


func _on_Timer_timeout() -> void:
	datos_nivel()
	var guardar_partida: GuardarCargar = GuardarCargar.new()
# warning-ignore:return_value_discarded
	guardar_partida.guardar_datos_partida()
	advertencia.visible = false


func _get_configuration_warning() -> String:
	if numero_nivel == 0 or siguiente_nivel == "":
		return "Eu fijate que te olvidaste de alguna de las export"
	
	else:
		return ""


func datos_nivel() -> void:
	DataDelJugador.nivel_actual = get_tree().current_scene.filename
	DataDelJugador.num_nivel_actual = numero_nivel
	DataDelJugador.nivel_siguiente = siguiente_nivel
