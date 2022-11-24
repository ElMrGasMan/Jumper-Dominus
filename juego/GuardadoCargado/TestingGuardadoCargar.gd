extends Node


func _on_BotonGuardado_pressed() -> void:
	if $NombreJSON.text != "":
		var guardar: GuardarCargar = GuardarCargar.new()
		var resultado_guardado: int = guardar.guardar_formato_json({"nombre": $NombreJSON.text})
		
		$TextoResultadoJSON.text = "%s" % resultado_guardado
	
	else:
		$TextoResultadoJSON.text = "El campo no puede estar vacío"


func _on_BotonCargado_pressed() -> void:
	var cargar: GuardarCargar = GuardarCargar.new()
	var datos_a_cargar: Dictionary = cargar.cargar_formato_json()
	
	if not datos_a_cargar.empty():
		$NombreJSON.text = datos_a_cargar.nombre
		$TextoResultadoJSON.text = "Carga de datos exitosa"
	
	else:
		$TextoResultadoJSON.text = "Carga de datos fallida"


func _on_BotonGuardadoTRES_pressed() -> void:
	if $NombreJSON.text != "":
		var guardar: GuardarCargar = GuardarCargar.new()
		var resultado_guardado: int = guardar.guardar_formato_tres({"nombre": $NombreJSON.text})
		
		$TextoResultadoJSON.text = "%s" % resultado_guardado
	
	else:
		$TextoResultadoJSON.text = "El campo no puede estar vacío"


func _on_BotonCargadoTRES_pressed() -> void:
	pass # Replace with function body.
