extends RayCast3D
@export var main_scene: Node3D;

var equippable_objects = ["dick", "balls", "shaft"];
var inventory_array = ["0", "0"];
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var selected = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if(Input.is_action_just_pressed("drop_item")):
		#if(inventory_array[selected] == "0"):
			#return
		#inventory_array[selected] = "0"
	
	if(is_colliding() && Input.is_action_pressed('interact')):
		force_raycast_update()
		if(get_collider() == null):
			return
		if(!get_collider().has_meta('name')):
			return
			
		var current_looked = get_collider().get_meta("name")
		var current_looked2 = get_collider()
		
		if current_looked == equippable_objects[0] or equippable_objects[1] or equippable_objects[2]:
			print("looking at " + current_looked)
			if(inventory_array[0] == "0"):
				inventory_array[0] = current_looked
				print("currently held in slot 1 is item: " + inventory_array[0])
				current_looked2.queue_free()
			elif(inventory_array[1] == "0"):
				inventory_array[1] = current_looked
				print("currently held in slot 2 is item: " + inventory_array[1])
				current_looked2.queue_free()
			else:
				print("retarded")
			
			
		
		
	
