extends CanvasLayer

@onready var _health_label = $HBoxContainer/HealthLabel
@onready var _ammo_label = $HBoxContainer/AmmoLabel

var _health: String : set = set_health
var _ammo: String : set = set_ammo

func set_health(value: String):
	_health = value
	_health_label.text = _health
	
func set_ammo(value: String):
	_ammo = value
	_ammo_label.text = _ammo
