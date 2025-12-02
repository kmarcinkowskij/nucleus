extends Node3D

@export var player_handle: Node3D


func _ready() -> void:
	player_handle.dropped_item.connect(on_item_dropped)
	
func _physics_process(delta: float) -> void:
	const msp = -3.5
	$NavigationRegion3D/Path3D/PathFollow3D.progress += msp * delta

func on_item_dropped(item_name):
	print(item_name)
