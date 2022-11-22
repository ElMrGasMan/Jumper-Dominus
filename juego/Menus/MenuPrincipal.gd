tool
extends Control


export(String, FILE, "*.tscn") var menu_opciones = ""

onready var sfx_seleccion: AudioStreamPlayer = $AudioStreamPlayer


func _on_ButtonSalir_pressed() -> void:
	get_tree().quit()


func _on_ButtonOpciones_pressed() -> void:
	sfx_seleccion.play()
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_opciones)


func _get_configuration_warning() -> String:
	if menu_opciones == "":
		return "No hay ningun menu de opciones asignado"
	
	return ""
