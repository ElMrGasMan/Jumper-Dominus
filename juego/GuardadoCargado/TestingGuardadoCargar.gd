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
	if $NombreTRES.text != "":
		var guardar: GuardarCargar = GuardarCargar.new()
		var resultado_guardado: int = guardar.guardar_formato_tres({"nombre": $NombreTRES.text})
		
		$TextoResultadoTRES.text = "%s" % resultado_guardado
	
	else:
		$TextoResultadoTRES.text = "El campo no puede estar vacío"


func _on_BotonCargadoTRES_pressed() -> void:
	var cargar: GuardarCargar = GuardarCargar.new()
	var datos_a_cargar: Dictionary = cargar.cargar_formato_tres()
	
	if not datos_a_cargar.empty():
		$NombreTRES.text = datos_a_cargar.nombre
		$TextoResultadoTRES.text = "Carga de datos exitosa"
	
	else:
		$TextoResultadoTRES.text = "Carga de datos fallida"


func _on_BotonBorradoJSON_pressed() -> void:
	var borrar_datos: GuardarCargar = GuardarCargar.new()
	var resultado: int = borrar_datos.borrar_datos_json()
	
	$TextoResultadoJSON.text = "%s" % resultado


func _on_BotonBorradoTRES_pressed() -> void:
	var borrar_datos: GuardarCargar = GuardarCargar.new()
	var resultado: int = borrar_datos.borrar_datos_tres()
	
	$TextoResultadoTRES.text = "%s" % resultado
