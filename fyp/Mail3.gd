extends Area2D

var mail_received = 0
signal mail_sent

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("mail_sent")


func _on_Area2D_mail_sent():
	get_tree().change_scene("res://GameOver.tscn")
