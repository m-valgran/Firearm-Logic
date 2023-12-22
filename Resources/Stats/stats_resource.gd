extends Resource

class_name Stats

@export var _max_health: int
@export var _health: int : set = set_health

signal no_health
signal health_changed

func set_health(value: int):
	_health = clamp(value,0,_max_health)
	health_changed.emit(_health)
	if _health <= 0:
		no_health.emit()
