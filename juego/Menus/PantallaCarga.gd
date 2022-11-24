class_name PantallaCarga
extends Control



func _on_Temporizador_timeout() -> void:
	if OS.get_name() in DatosConfiguracion.OS_ADMITIDOS_PARA_THREADS:
		CargaNivelSegPlano.cargar_nivel_siguiente(DataDelJugador.nivel_actual)
	
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene(DataDelJugador.nivel_actual)
