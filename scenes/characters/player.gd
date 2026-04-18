extends CharacterBody2D
class_name Player

enum ControlScheme {CPU, P1, P2}

@export var speed : float = 80
@export var controlscheme : ControlScheme

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sprite_2d: Sprite2D = %Sprite2D


var heading : Vector2 = Vector2.RIGHT


func _process(delta: float) -> void:
	# 控制角色移动
	if controlscheme == ControlScheme.CPU:
		# AI移动
		pass
	else :
		# 玩家移动
		handle_human_movement()
	
	# 处理玩家朝向
	set_heading()
	
	# 根据角色速度播放相应动画
	set_movement_animation()
	
	# 调用内置方法来实现角色移动
	move_and_slide()
	
## 如果角色是真人控制，则使用该函数控制角色移动
func handle_human_movement():
	# 获取角色运动方向
	var direction = KeyUtils.get_input_vector(controlscheme)
	# 计算角色速度Vector2D
	velocity = direction * speed
	
## 根据角色速度播放相应动画
func set_movement_animation():
	if velocity.length() > 0:
		animation_player.play("run")
	else :
		animation_player.play("idle")
		
## 处理玩家朝向
func set_heading():
	if velocity.x > 0:
		heading = Vector2.RIGHT
	if velocity.x < 0:
		heading = Vector2.LEFT
		
	# 根据朝向处理动画翻转
	if heading == Vector2.RIGHT:
		sprite_2d.flip_h = false
	if heading == Vector2.LEFT:
		sprite_2d.flip_h = true
