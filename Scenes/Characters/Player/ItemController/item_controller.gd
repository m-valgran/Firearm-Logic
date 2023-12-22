# TODO: Validate empty _items array

extends Node2D

@onready var _items: Array[Node] = get_children()
@onready var _selected_item: Node

func _ready():
	if _items.size() > 0:
		_selected_item = _items[0]
		set_selected_item(0)

func _process(_delta):
	use_selected_item()
	reload_current_item()
	switch_items()

func use_selected_item():
	if Input.is_action_pressed("ui_lmb"):
		if _selected_item._resource is Weapon:
			_selected_item.attack()
			if _selected_item is RangedWeapon:
				Hud._ammo = _selected_item.get_ammo_info()

func reload_current_item():
	if Input.is_action_pressed("ui_reload"):
		if _selected_item is RangedWeapon:
			_selected_item.reload()

func switch_items():
	if Input.is_action_just_released("ui_scroll_up"):
		set_selected_item(_items.find(_selected_item) + 1)
	if Input.is_action_just_released("ui_scroll_down"):
		set_selected_item(_items.find(_selected_item) - 1)

func set_selected_item(index):
	_selected_item.visible = false
	if _selected_item is RangedWeapon:
		_selected_item.abort_reload()
		if _selected_item.is_connected("reload_finished",on_selected_item_reload_finished):
			_selected_item.disconnect("reload_finished",on_selected_item_reload_finished)
	var next_item_index = clamp(index,0,_items.size()-1)
	_selected_item = _items[next_item_index]
	_selected_item.visible = true
	if _selected_item is RangedWeapon:
		Hud._ammo = _selected_item.get_ammo_info()
		_selected_item.connect("reload_finished",on_selected_item_reload_finished)
	elif _selected_item is MeleeWeapon:
		Hud._ammo = ""

func on_selected_item_reload_finished():
	if _selected_item is RangedWeapon:
		Hud._ammo = _selected_item.get_ammo_info()
