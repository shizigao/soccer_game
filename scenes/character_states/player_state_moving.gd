extends PlayerState
class_name PlayerStateMoving


func _process(delta: float) -> void:
	# 控制角色移动
	if player.controlscheme == Player.ControlScheme.CPU:
		# AI移动
		pass
	else :
		# 玩家移动
		player.handle_human_movement()
	
	# 处理玩家朝向
	player.set_heading()
	
	# 根据角色速度播放相应动画
	player.set_movement_animation()
	
	# 处理转换状态逻辑
	# 切换到tackling状态
	if !player.has_ball() and player.velocity != Vector2.ZERO and KeyUtils.is_action_just_pressed(player.controlscheme, KeyUtils.Action.SHOOT):
		state_transition_requested.emit(Player.State.TACKLING)
	# 切换到预射门状态
	if player.has_ball() and KeyUtils.is_action_just_pressed(player.controlscheme, KeyUtils.Action.SHOOT):
		state_transition_requested.emit(Player.State.PREPARE_SHOOT)
	
## 如果角色是真人控制，则使用该函数控制角色移动
func handle_human_movement():
	# 获取角色运动方向
	var direction = KeyUtils.get_input_vector(player.controlscheme)
	# 计算角色速度Vector2D
	player.velocity = direction * player.speed
	
