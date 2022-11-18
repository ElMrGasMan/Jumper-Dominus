class_name Moneda
extends Area


onready var colisionador: CollisionShape = $CollisionShape
onready var animaciones: AnimationPlayer = $AnimationPlayer


# warning-ignore:unused_argument
func _on_body_entered(body: Node) -> void:
	DataDelJugador.obtener_moneda()
	colisionador.set_deferred("disabled", true)
	animaciones.play("Consumir")
