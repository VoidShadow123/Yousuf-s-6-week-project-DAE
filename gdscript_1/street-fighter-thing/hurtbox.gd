class_name hurtbox
extends Area2D

func _ready():
	collision_layer = 0
	collision_mask = 2
	self.area_entered.connect(on_area_entered)

func on_area_entered(hitbox:) -> void:
	if hitbox == null: return
	#TODO deal damage
	print("Damage Dealt")
