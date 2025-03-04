extends Area2D

var bullet_speed := 300.0
var direction := 1 

func set_direction(dir):
	direction = dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += bullet_speed * delta * direction


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
