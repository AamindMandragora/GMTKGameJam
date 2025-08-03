extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.is_water_mode:
		visible = true
	else:
		visible = false
