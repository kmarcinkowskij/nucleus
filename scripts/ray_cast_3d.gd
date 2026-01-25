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
	#if(is_colliding()):
		#print(get_collider())
	if(is_colliding() && Input.is_action_just_pressed('interact') && get_collider().has_meta("interactable")):
		if(get_collider().get_meta("interactable") == false):
			return
		print("interacting with: " + str(get_collider().get_meta("id")))
		if(get_collider() == null):
			return
		if(!get_collider().has_meta('id')):
			return
			
		var current_looked = get_collider()
		
		emit_signal("picked_up_item", current_looked)
			
		
		
	
