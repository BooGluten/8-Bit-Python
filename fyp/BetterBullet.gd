extends RigidBody2D

var enemy_scene = load("res://Enemy.tscn")
var enemy = enemy_scene.instance()
var appear_time = 5

var speed = 1500
var damage = 200

func _ready():
	apply_impulse(Vector2(), Vector2(speed, 0).rotated(rotation))
	connect("body_entered", self, "_on_Bullet_body_enter")
	
#Make bullets disappear after a certain time
func Disappear():
	yield(get_tree().create_timer(appear_time), "timeout")
	queue_free()

func _on_BetterBullet_body_entered(body):
	self.hide()
	get_node("CollisionShape2D").set_deferred("disabled", true) 
	if body.is_in_group("Enemies"):
		body.HasBeenShot(damage)
