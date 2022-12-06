extends Control


onready var contenedor_vidas = $ContenedorVidas/Cant
onready var contenedor_monedas_bronce = $ContenedorMonedasBronce/Cant
#onready var contenedor_monedas_plata = $ContenedorMonedasPlata/Cant
#onready var contenedor_monedas_oro = $ContenedorMonedasOro/Cant


func _ready():
# warning-ignore:return_value_discarded
	Eventos.connect("actualizar_datos_hud", self, "actualizar_datos")
	actualizar_datos()


func actualizar_datos():
	contenedor_vidas.text = "%s" % DataDelJugador.vidas
	contenedor_monedas_bronce.text = "%s" % DataDelJugador.monedas
	#contenedor_monedas_plata.text = "%s" % DataDelJugador.monedas_plata
	#contenedor_monedas_oro.text = "%s" % DataDelJugador.monedas_oro
