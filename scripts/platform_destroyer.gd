extends Area3D


func _on_body_entered(body: Node3D) -> void:
	print("body entered: ", body)
	body.queue_free()


func _on_area_entered(area: Area3D) -> void:
	print("area entered: ", area)
	area.get_parent().get_parent().queue_free()
