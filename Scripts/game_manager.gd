extends Node

var score = 0
var level = 1

func add_point():
	score += 1
	print(score)

func next_level(next_level_path: String):
	level += 1
	get_tree().change_scene_to_file(next_level_path)
