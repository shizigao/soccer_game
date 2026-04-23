extends CharacterBody2D
class_name Player

enum ControlScheme {CPU, P1, P2}
enum State {MOVING, TACKLING, RECOVERING, PREPARE_SHOOT, SHOOTING, PASSING}
## 玩家移动速度
@export var speed : float = 80
## 射门力量
@export var power : float = 70.0
## 玩家控制策略
@export var controlscheme : ControlScheme
## 玩家（是否）持有球
@export var ball : Ball

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var teammate_detection_area: Area2D = %TeammateDetectionArea


## 玩家朝向
var heading : Vector2 = Vector2.RIGHT
## 玩家当前的状态
var current_state : PlayerState = null
## 状态工厂
var state_factory := PlayerStateFactory.new()
## 状态数据
var state_data : PlayerStateData = PlayerStateData.new()


func _ready() -> void:
	# 初始为MOVING状态
	switch_state(State.MOVING)
	
func _process(delta: float) -> void:
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
		
## 切换状态
func switch_state(state: State):
	# 若状态已经存在，则销毁
	if current_state != null:
		current_state.queue_free()
	# 从状态工厂获取状态（并初始化）
	current_state = state_factory.get_fresh_state(state)
	if current_state == null:
		printerr("玩家状态转换失败")
	current_state.setup(self, animation_player)
	current_state.state_transition_requested.connect(switch_state)
	# 将新建的状态加入树中
	add_child.call_deferred(current_state)
	
## 判断玩家是否持有球
func has_ball() -> bool:
	return ball.carrier == self
