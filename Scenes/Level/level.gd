extends Node

@onready var _enemy = $Enemy
@onready var _player = $Player

func _process(_delta):
	if is_instance_valid(_enemy):
		_enemy._current_target = _player.position
