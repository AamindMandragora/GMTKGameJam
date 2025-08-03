extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").disabled = true
	timer.start()

func _on_timer_timeout() -> void:
	
	Engine.time_scale = 1
	# Reset all nodes in the "resettable" group
	for node in get_tree().get_nodes_in_group("resettable"):
		if node.has_method("reset_to_start"):
			node.reset_to_start()
