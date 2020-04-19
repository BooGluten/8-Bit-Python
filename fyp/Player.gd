extends KinematicBody2D

const GRAVITY = 500.0
const WALK_SPEED = 200
const MAX_X_SPEED = 300

var velocity = Vector2()
var body = self
var bullet_speed = 400
var can_fire = true
var rate_of_fire = 0.4
var shooting = false

var bullet_scene = preload("res://Bullet.tscn")
var better_gun_scene = preload("res://BetterBullet.tscn")
var better_gun = false

func _process(delta):
	ShootLoop()
	if better_gun:
		ShootBetterLoop()
	
func _ready():
	add_to_group("Player")
	connect("body_entered", self, "_on_Player_body_enter")

func _physics_process(delta):
	
	velocity.y += delta * GRAVITY
	if Input.is_action_pressed("ui_left"):
		velocity.x += -WALK_SPEED
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_right"):
		velocity.x +=  WALK_SPEED
		$Sprite.flip_h = true
		
	
	if abs(velocity.x) > MAX_X_SPEED:
		velocity.x = MAX_X_SPEED * sign(velocity.x)

	if is_on_floor():
		velocity.y = 0
		if Input.is_action_pressed("ui_up"):
			velocity.y = -(WALK_SPEED * 1.5)

	#This method allows the is_on_floor() method to be used and
	#makes running on the ground smoother, as well as collision checks
	move_and_slide(velocity, Vector2(0, -1), false, 4, 0.785398, false)
	var osign = sign(velocity.x)
	velocity.x -= 50 * sign(velocity.x)
	if sign(velocity.x) != osign:
		velocity.x = 0
	if get_position().y >= 3750:
		_death_scene()
		
	for body in get_slide_count():
		var collision = get_slide_collision(body)
		if collision.collider.is_in_group("Enemies"):
			_death_scene()


func _death_scene():
	# If you are killed the whole level restarts
	get_tree().reload_current_scene()
	
func ShootLoop():
	if Input.is_action_pressed("shoot") and can_fire == true and better_gun == false:
		can_fire = false
		var bullet = bullet_scene.instance()
		# using the axies I placed on the player model as
		# starting position for bullets, once player is scaled to level
		# change position for bullets
		if $Sprite.flip_h == false:
			$ShootAxis/ShootPoint.position.set(-position)
			bullet.position = position+get_node("ShootAxis/ShootPoint").position*scale
		bullet.position = position+get_node("ShootAxis/ShootPoint").position*scale
		#bullet.rotate(rot)
		velocity.x -= 950
		get_parent().add_child(bullet)
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		
func ShootBetterLoop():
	if Input.is_action_pressed("shoot") and can_fire == true and better_gun:
		can_fire = false
		var better_bullet = better_gun_scene.instance()
		better_bullet.position = position+get_node("ShootAxis/ShootPoint").position*scale
		velocity.x -= 950
		get_parent().add_child(better_bullet)
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
	
func HasGottenGun():
	better_gun = true
