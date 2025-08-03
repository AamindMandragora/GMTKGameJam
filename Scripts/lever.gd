extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if Globals.is_water_mode == false:
		Globals.is_water_mode = true
		print("e")
