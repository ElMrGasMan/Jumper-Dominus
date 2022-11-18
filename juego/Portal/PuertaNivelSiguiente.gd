extends Area


export(String, FILE, "*.tscn") var siguiente_nivel = ""


# warning-ignore:unused_argument
func _on_body_entered(body: Node) -> void:
	if siguiente_nivel != "":
# warning-ignore:return_value_discarded
		get_tree().change_scene(siguiente_nivel)
