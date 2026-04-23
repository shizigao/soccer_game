extends PlayerState
class_name PlayerStatePassing

func _enter_tree() -> void:
	# 播放动画
	animation_player.play("kick")
	animation_player.animation_finished.connect(_on_animation_finished)


func _on_animation_finished(anim_name: StringName):
	# 寻找视野内可传球的队友
	var pass_target = find_teammate_in_view()
	print(pass_target)
	# 状态转换
	if player.controlscheme == Player.ControlScheme.CPU:
		state_transition_requested.emit(Player.State.RECOVERING)
	else:
		state_transition_requested.emit(Player.State.MOVING)
		
func shoot():
	player.ball.shoot(player.state_data.shoot_direction, player.state_data.shoot_power)

func find_teammate_in_view():
	# 获取视野内的所有玩家
	var players_in_view := player.teammate_detection_area.get_overlapping_bodies()
	# 过滤自己
	var teammates_in_view := players_in_view.filter(
		func(p: Player) -> bool:
			return p != player
	)
	# 根据距离排序
	teammates_in_view.sort_custom(
		func(p1 : Player, p2 : Player):
			return p1.position.distance_squared_to(player.position) < p2.position.distance_squared_to(player.position)
	)
	# 返回最近的那一个队友
	if teammates_in_view.size() > 0:
		return teammates_in_view[0]
	else:
		return null
	
