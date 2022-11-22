class_name MenuPresentacion
tool
extends Control


export(String, FILE, "*.tscn") var menu_inicio = ""


func _get_configuration_warning() -> String:
	if menu_inicio == "":
		return "No hay ningun menu de inicio asignado"
	
	return ""


func cargar_menu() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_inicio)
