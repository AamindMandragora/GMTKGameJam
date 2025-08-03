extends Area2D

@onready var lever: Sprite2D = $Lever

func _on_body_entered(body: Node2D) -> void:
	if not Globals.is_water_mode:
		Globals.is_water_mode = true
		
		# Reset all nodes in the "resettable" group
		for node in get_tree().get_nodes_in_group("resettable"):
			if node.has_method("reset_to_start"):
				node.reset_to_start()


func _process(delta: float) -> void:
	if not Globals.is_water_mode:
		lever.flip_h = false
	else:
		lever.flip_h = true
