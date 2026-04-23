extends BallState
class_name BallStateFreeform



func _enter_tree() -> void:
	player_detection_area.body_entered.connect(_on_player_entered)
	
func _process(delta: float) -> void:
	# 播放动画
	set_ball_animation_from_velocity()
	# 处理摩擦力
	process_friction(delta)
	# 处理重力
	process_gravity(delta)
		
	ball.move_and_collide(ball.velocity * delta)
	
	
func _on_player_entered(body: Player):
	ball.carrier = body
	state_transition_requested.emit(Ball.State.CARRIED)
	
