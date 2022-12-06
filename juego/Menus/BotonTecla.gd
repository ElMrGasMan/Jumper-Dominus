class_name BotonConfigTecla
tool
extends Button


export var accion: String

var traducciones: Dictionary = {
	"Space": "Espacio",
	"Up": "Flecha Arriba",
	"Down": "Flecha Abajo",
	"Right": "Flecha Derecha",
	"Left": "Flecha Izquierda",
	"CapsLock": "Bloq Mayus"
}


func _ready() -> void:
	assert(InputMap.has_action(accion))
	set_process_unhandled_input(false)
	input_actual()


func _on_toggled(button_pressed: bool) -> void:
	set_process_unhandled_input(button_pressed)
	
	if button_pressed:
		text = "Asignar Tecla"
		release_focus()
	
	else: 
		input_actual()


func _unhandled_input(event: InputEvent) -> void:
	cambiar_tecla_accion(event)
	pressed = false


func input_actual() -> void:
	var input_tecla: String = InputMap.get_action_list(accion)[0].as_text()
	text = traducir_input(input_tecla)


func _get_configuration_warning() -> String:
	if accion == "":
		return "No hay ninguna accion asignada"
	
	return ""


func cambiar_tecla_accion(event: InputEvent) -> void:
	InputMap.action_erase_events(accion)
	InputMap.action_add_event(accion, event)
	text = traducir_input(event.as_text())


func traducir_input(texto_input: String) -> String:
	if texto_input in traducciones:
		return traducciones[texto_input]
	
	return texto_input
