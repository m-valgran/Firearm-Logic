extends Area2D

var _damage: int #: get = get_hitbox_damage
var _knockback_ammount: int

func disable(value: bool):
	$CollisionShape2D.set_deferred("disabled", value)
	
#func get_hitbox_damage():
#	return _damage

func get_knockback():
	var front = to_global(Vector2.RIGHT)
	var knockback_direction = global_position.direction_to(front)
	return knockback_direction * _knockback_ammount
