extends RayCast3D

@export var n_INVENTORY_NODE: Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_colliding() && Input.is_action_pressed('interact')):
		n_INVENTORY_NODE.add_child(get_collider())
		get_collider().queue_free()
		
		
	
