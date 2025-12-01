extends Node3D

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	const msp = -3.5
	$NavigationRegion3D/Path3D/PathFollow3D.progress += msp * delta
