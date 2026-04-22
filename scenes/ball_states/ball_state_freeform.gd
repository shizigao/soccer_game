extends BallState
class_name BallStateFreeform

func _enter_tree() -> void:
	player_detection_area.body_entered.connect(_on_player_entered)
	
func _on_player_entered(body: Player):
	ball.carrier = body
	state_transition_requested.emit(Ball.State.CARRIED)
	
