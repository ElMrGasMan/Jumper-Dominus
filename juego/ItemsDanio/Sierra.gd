class_name Sierra
extends Area


func _on_body_entered(body: Node) -> void:
	if body is Jugador:
		body.respawn()
