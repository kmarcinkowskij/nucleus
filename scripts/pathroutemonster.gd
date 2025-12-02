extends PathFollow3D
@onready var runnerer = $PathFollow3D
func _ready() -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	const speed = 3.5
	runnerer.Progress += speed * delta
