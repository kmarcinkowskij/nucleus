class_name interactables
extends Node3D

var object_scenes: Dictionary = {
	0: load("res://resources/interactable_objects/interactable_0.tscn"),
	1: load("res://resources/interactable_objects/interactable_1.tscn"),
	2: load("res://resources/interactable_objects/interactable_2.tscn"),
	3: load("res://resources/interactable_objects/interactable_3.tscn"),
	4: load("res://resources/interactable_objects/medkit.tscn"),
	5: load("res://resources/interactable_objects/medkit_big.tscn")
	}
# Called when the node enters the scene tree for the first time.

func spawn(index) -> PackedScene:
	print(index)
	return object_scenes.get(index)

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
