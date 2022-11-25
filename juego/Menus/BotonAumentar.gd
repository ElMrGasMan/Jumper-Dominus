class_name BotonSFX
extends Button


export(NodePath) var nodo_sfx

var boton_sfx: AudioStreamPlayer


func _ready() -> void:
# warning-ignore:return_value_discarded
	connect("pressed", self, "emitir_sonido")
	boton_sfx = get_node(nodo_sfx)


func emitir_sonido() -> void:
	boton_sfx.play()
