extends RigidBody2D

class_name Projectile

func setup_hitbox(damage: int, knockback_ammount: int):
	var hitbox = $Hitbox
	hitbox._damage = damage
	hitbox._knockback_ammount = knockback_ammount

func _on_timer_timeout():
	queue_free()

func _on_hitbox_area_entered(_hurtbox):
	queue_free()
