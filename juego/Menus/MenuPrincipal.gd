tool
extends Control


export(String, FILE, "*.tscn") var menu_opciones = ""
export(String, FILE, "*.tscn") var nivel_inicial = ""
export(String, FILE, "*.tscn") var pantalla_carga = ""

onready var sfx_seleccion: AudioStreamPlayer = $AudioStreamPlayer


func _on_ButtonSalir_pressed() -> void:
	get_tree().quit()


func _on_ButtonOpciones_pressed() -> void:
	sfx_seleccion.play()
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_opciones)


func _on_ButtonNueva_pressed() -> void:
	sfx_seleccion.play()
# warning-ignore:return_value_discarded
	DataDelJugador.nivel_actual = nivel_inicial
	get_tree().change_scene(pantalla_carga)


func _get_configuration_warning() -> String:
	if menu_opciones == "" or nivel_inicial == "" or pantalla_carga == "":
		return "Algun export no esta cargado"
	
	return ""
