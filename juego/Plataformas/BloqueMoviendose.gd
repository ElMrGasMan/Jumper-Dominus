class_name MovimientoPlataforma
extends StaticBody


export(String, "Movimiento_ZPositivo", "Movimiento_YPositivo", "Movimiento_XPositivo") var vector_movimiento

onready var animaciones: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animaciones.play(vector_movimiento)
