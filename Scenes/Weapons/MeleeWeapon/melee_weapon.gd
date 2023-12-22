extends Node2D

class_name MeleeWeapon

@export var _resource: Weapon

@onready var _hitbox: Area2D = $Hitbox
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	_hitbox.disable(true)
	_hitbox._damage = _resource._damage
	_hitbox._knockback_ammount = _resource._knockback

func attack():
	if _resource._can_activate:
		_animation_player.play("Attack")
		_hitbox.disable(false)
		_resource._can_activate = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		_hitbox.disable(true)
		_resource._can_activate = true

func _on_hitbox_area_entered(_area):
	_hitbox.disable(true)
