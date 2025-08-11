extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		print("You Died")
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	
