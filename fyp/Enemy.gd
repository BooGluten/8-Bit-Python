extends RigidBody2D

const WALK_SPEED = 20
const GRAVITY = 500.0

onready var hole_raycaster = RayCast2D.new()
export var RAY_LENGTH = 5
export var initial_movement = 1

var player_scene = preload("res://Player.tscn")
var player = player_scene.instance()
var to_player = player.global_position - self.global_position

var velocity = Vector2()
var move_dir = 0
var attack_range = 10
var current_hp = 200


func _physics_process(delta):
	var pg = get_tree().get_nodes_in_group("Player")
	if len(pg):
		var v = global_position.direction_to(pg[0].global_position).angle()
		hole_raycaster.set_global_rotation(v-11.0/7.0)
		var direction = (hole_raycaster.rotation)
		var motion = direction * WALK_SPEED * delta
		if to_player.length() <= attack_range:
			if (direction >= -5 && direction <= -3):
				position += Vector2(motion, 0)
			if (direction >= -2.9 && direction <= -1):
				position += Vector2(-motion, 0)

func _ready():
	add_to_group("Enemies")
	add_child(hole_raycaster)
	hole_raycaster.add_exception(self)
	hole_raycaster.set_enabled(true)
	
	
func HasBeenShot(damage):
	current_hp -= damage
	if current_hp <= 0:
		_death_scene()
	
	
func _death_scene():
	# Turn off collision shape for enemies once they are hit so they
	# cannot be hit again and do not get in the way of player's movement
	get_node("CollisionShape2D").set_deferred("disabled", true) 
	self.hide()   
