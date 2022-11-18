class_name Nivel
tool
extends Node


export(String, FILE, "*.tscn") var siguiente_nivel = ""
export var numero_nivel: int = 0


func _ready() -> void:
	DataDelJugador.nivel_actual = get_tree().current_scene.filename
	DataDelJugador.num_nivel_actual = numero_nivel
	DataDelJugador.nivel_siguiente = siguiente_nivel


func _get_configuration_warning() -> String:
	if numero_nivel == 0 or siguiente_nivel == "":
		return "Eu fijate que te olvidaste de alguna de las export"
	
	else:
		return ""
