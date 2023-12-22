extends CharacterBody2D

class_name Player

var alive = true

# how to verify not null below?
@export var _stats: Stats
@export var _movement: Movement

@onready var _soft_collision = $SoftCollision

func _ready():
	_stats.connect("no_health",on_stats_no_health)
	_stats.connect("health_changed",on_stats_health_changed)
	Hud._health = str(_stats._health)

func _physics_process(_delta):
	if alive:
		move()

func move():
	var input_x = Input.get_axis("ui_left", "ui_right")
	var input_y = Input.get_axis("ui_up", "ui_down")
	var direction = Vector2(input_x,input_y).normalized()
	_movement.walk(self,direction,get_global_mouse_position())
	velocity += _soft_collision.get_repulsion_vector()

func on_stats_no_health():
	alive = false

func on_stats_health_changed(value):
	Hud._health = str(value)

func _on_hurtbox_area_entered(hitbox):
	_stats._health -= hitbox._damage
