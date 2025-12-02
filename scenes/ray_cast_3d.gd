extends RayCast3D
@export var player_scene: Node3D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#equippable_objects = player_scene
	#equippable_objects = GlobalVars.equippable_objects

signal picked_up_item(item_id);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	if(is_colliding() && Input.is_action_pressed('interact')):
		force_raycast_update()
		if(get_collider() == null):
			return
		if(!get_collider().has_meta('id')):
			return
			
		var current_looked = get_collider()
		
		emit_signal("picked_up_item", current_looked)
			
		
		
	
