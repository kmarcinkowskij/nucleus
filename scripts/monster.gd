extends CharacterBody3D
var sees_player = false
var target = null
var player = null
@export var chasepoints = 10
var ustates = ["PATROL", "CHASE"]
const faster = 5.0
var ustate_current = ustates[0]

var body = null
@export var target_path : NodePath
@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D

func _ready() -> void:
	target = get_node(target_path)
	player = get_node(player_path)
	print(ustate_current)
func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO

	
	#$Vision.look_at(Vector3(player.global_position.x, player.global_position.y, player.global_position.z), Vector3.UP)
	#if $Vision.is_colliding():
		#var colloderer = $Vision.get_collider()
		#
		#if colloderer == player:
			#print("faggot")
	##$Vision.target_position = $Vision.to_local(playerlocation)
	#$Vision.target_position = $Vision.to_local(Vector3(player.global_position.x, player.global_position.y, player.global_position.z))
	#$Vision.force_raycast_update()
	#var sees_player: bool = $Vision.is_colliding() and $Vision.get_collider() == player
	#$Vision.force_raycast_update()
	if sees_player:
		if ustate_current != "CHASE":
			chasepoints = 10  
		ustate_current = "CHASE"
	elif ustate_current == "CHASE" and chasepoints <= 0:
		ustate_current = "PATROL"
#
	#print("state:", ustate_current, " sees:", $Vision.get_collider(), " chasepoints:", chasepoints)

	if ustate_current == "CHASE":
		
		nav_agent.set_target_position(player.global_position)
		var next_nav_point = nav_agent.get_next_path_position()
		var dir = (next_nav_point - global_position).normalized()
		velocity = dir * faster
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	else:
		
		$AudioStreamPlayer3D.play()
		nav_agent.set_target_position(target.global_position)
		var next_nav_point = nav_agent.get_next_path_position()
		var dir = (next_nav_point - global_position).normalized()
		velocity = dir * faster
		look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)

	move_and_slide()
func _on_chase_timer_timeout() -> void:
	chasepoints=chasepoints-1
	var overlaper = $vision1.get_overlapping_bodies()
	if overlaper.size() > 0:
		for overlap in overlaper:
			if overlap.name == "player":
				print("faggot nearby")
				
				$Vision.look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
				$Vision.force_raycast_update()
				if $Vision.is_colliding():
					var collisionsrc = $Vision.get_collider()
					print(collisionsrc)
					if collisionsrc.name == "player":
						print("faggot spotted CHASE GO")
						sees_player = true
			else:
				#print("no faggot nearby, killing myself")
				sees_player = false
				
