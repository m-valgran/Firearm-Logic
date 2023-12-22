extends Node2D

class_name RangedWeapon

@export var _resource: Weapon

@export var _projectile: PackedScene

@export var _fire_rate: int
@export var _muzzle_velocity: int
@export var _reload_time: float

@export var _capacity: int
@export var _mag: int
@export var _reserve: int

var _reloading = false

@onready var _muzzle_timer = $MuzzleTimer
@onready var _reload_timer = $ReloadTimer
@onready var _muzzle = $Muzzle
@onready var _root = get_tree().root

signal reload_finished

func _ready():
	_reload_timer.wait_time = _reload_time
	_muzzle_timer.wait_time = 60.0 / _fire_rate

func attack():
	if _resource._can_activate && _mag > 0 && !_reloading:
		spawn_projectile()
		_mag -= 1
		_resource._can_activate = false
		_muzzle_timer.start()
#		print(_mag, "/", _reserve)

func spawn_projectile():
	var projectile_node = _projectile.instantiate()
	if projectile_node is Projectile:
		projectile_node.transform = _muzzle.global_transform
		projectile_node.setup_hitbox(_resource._damage,_resource._knockback)
		_root.add_child(projectile_node)
		var direction = Vector2.RIGHT.rotated(_muzzle.global_rotation)
		projectile_node.apply_central_force(direction * _muzzle_velocity)

func reload():
	if _reserve > 0 && _mag < _capacity && !_reloading:
#		print("reloading...")
		_reload_timer.start()
		_reloading = true

func abort_reload():
	if _reloading:
#		print("aborting reload")
		_reloading = false
		_reload_timer.stop()
		
func get_ammo_info():
	return str(_mag)+"/"+str(_reserve)

func _on_muzzle_timer_timeout():
	_resource._can_activate = true

func _on_reload_timer_timeout():
	var rounds = _capacity - _mag
	_mag = clamp(_capacity, 0, _reserve+_mag)
	_reserve = clamp(_reserve - rounds, 0, _reserve)
	_reloading = false
	_resource._can_activate = true
	reload_finished.emit()
#	print(_mag, "/", _reserve)
