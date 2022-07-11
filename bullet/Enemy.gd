extends Node2D

const bullet_scene = preload("res://bullet/Bullet.tscn")
onready var shoot_timer = $ShootTimer
onready var rotater = $Rotater

const rotate_speed = 100
const shooter_timer_wait_time = 0.2
const spawn_point_count = 4
const radius = 100

func _ready():
		var step = 2*3.14 / spawn_point_count
		
		for i in range (spawn_point_count):
			var spawn_point = Sprite.new()
			var pos = Vector2(radius,0).rotated(step * 1)
			spawn_point.position = pos
			spawn_point.rotation = pos.angle()
		shoot_timer.wait_time = shooter_timer_wait_time
		shoot_timer.start() 

func _process(delta: float)-> void:
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees= fmod(new_rotation,360)

func _on_ShootTimer_timeout()-> void:
	for s in rotater.get_children():
		var bullet = bullet_scene.instance()
		get_tree().root.add_child(bullet)
		bullet.position =s.global_position
		bullet.rotation =s.global_rotation
