extends Resource

class_name Movement

@export var _speed: int
@export var _acceleration: int
@export var _friction: int

func walk(character: CharacterBody2D, direction: Vector2, look_at: Vector2):
	var to
	var delta
	if direction != Vector2.ZERO:
		to = direction * _speed
		delta = _acceleration
	else:
		to = Vector2.ZERO
		delta = _friction
	character.velocity = character.velocity.move_toward(to,delta)
	character.look_at(look_at)
	character.move_and_slide()
	
