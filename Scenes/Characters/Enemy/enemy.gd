extends CharacterBody2D

# how to verify not null below?
@export var _stats: Stats
@export var _movement: Movement

@onready var _player_detector: Node2D = $PlayerDetector
@onready var _soft_collision: Area2D = $SoftCollision

@onready var _melee_weapon = get_node_or_null("MeleeWeapon")

var _current_target: Vector2

func _ready():
	_stats.connect("no_health",on_stats_no_health)
	
func _physics_process(_delta):
	move()
	attack_player()

func on_stats_no_health():
	queue_free()

func move():
	var direction = Vector2.ZERO
	if _current_target:
		direction = position.direction_to(_current_target)
	_movement.walk(self,direction,_current_target)
	velocity += _soft_collision.get_repulsion_vector()

func attack_player():
	if _melee_weapon:
		for raycast in _player_detector.get_children():
			if raycast.is_colliding() and raycast.get_collider() is Player:
				_melee_weapon.attack()

func _on_hurtbox_area_entered(hitbox):
	velocity = hitbox.get_knockback()
	_stats._health -= hitbox._damage
