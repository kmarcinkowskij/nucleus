extends CanvasLayer

@onready var player: CharacterBody3D = $".."

@onready var HealthBar: ProgressBar = $"in-game HUD/HealthBar"
@onready var StaminaBar: ProgressBar = $"in-game HUD/StaminaBar"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	HealthBar.value = player.Health
	StaminaBar.value = player.Stamina
