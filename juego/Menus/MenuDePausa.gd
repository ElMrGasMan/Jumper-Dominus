extends Control


func _ready():
	visible = false


func _input(event):
	if event.is_action_pressed("pausar"):
		visible = true
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_ButtonContinuar_pressed():
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_ButtonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().paused = false
	get_tree().change_scene("res://juego/Menus/MenuPrincipal.tscn")


func _on_ButtonSalir_pressed() -> void:
	get_tree().quit()
