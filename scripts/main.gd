extends Node3D

@export var player_handle: Node3D
var interactables_controller = interactables.new();

func _ready() -> void:
	player_handle.dropped_item.connect(on_item_dropped)
	
	
func _physics_process(delta: float) -> void:
	const msp = -3.5
	$NavigationRegion3D/Path3D/PathFollow3D.progress += msp * delta

func on_item_dropped(item_name):
	var current_player_position = player_handle.position;
	var child = interactables_controller.spawn(item_name).instantiate();
	self.add_child(child)
	child.get_child(0).set_meta("id", item_name)
	child.position = Vector3(current_player_position.x,0.7,current_player_position.z)
