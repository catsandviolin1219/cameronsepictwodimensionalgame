extends Area2D

func _ready():
	var obj = load("res://Resources/obj/2.tscn")
	var instance = obj.instance()
	instance.position = position
	get_parent().add_child(instance)