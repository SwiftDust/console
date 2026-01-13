extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var burst_timer = $BurstTimer
@onready var score = $"../Score"
@onready var animated_sprite_2d = $Sprite2D
var jumping := false
var jump_begin := false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		animated_sprite_2d.play("idle")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		burst_timer.start()
		jumping = true
		animated_sprite_2d.play("jump_begin")
		jump_begin = true
	
	if not Input.is_action_pressed("jump"):
		burst_timer.stop()
		jumping = false
		animated_sprite_2d.play("jump_end")
		
	if jumping:
		velocity.y = JUMP_VELOCITY 
	
	# TODO: custom tilting behavior
	var direction := Input.get_axis("tilt_left", "tilt_right")
	var both_pressed := false
	if Input.is_action_pressed("tilt_left") and Input.is_action_pressed("tilt_right"):
		direction = 0
		both_pressed = true
	
	if not direction == 0:
		velocity.x = direction * SPEED
	if both_pressed == true:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	score.update_score(roundi(max(0, -position.y)))
	move_and_slide()


func _on_burst_timer_timeout() -> void:
	jumping = false


func _on_sprite_2d_animation_finished() -> void:
	if jump_begin == true:
		animated_sprite_2d.play("jump_midair")
		jump_begin = false
