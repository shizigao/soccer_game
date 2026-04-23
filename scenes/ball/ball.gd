extends AnimatableBody2D
class_name Ball

enum State {CARRIED, FREEFORM, SHOT}
@onready var player_detection_area: Area2D = %PlayerDetectionArea
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var ball_sprite: Sprite2D = %BallSprite


var velocity : Vector2 = Vector2.ZERO
var height_velocity : float = 0
var ball_state_factory : BallStateFactory = BallStateFactory.new()
var current_state : BallState = null
var carrier : Player = null
var height : float = 0.0



func _ready() -> void:
	switch_state(State.FREEFORM)
	
func _process(delta: float) -> void:
	# 更新精灵的高度
	ball_sprite.position = Vector2.UP * height

func switch_state(new_state: State):
	if current_state != null:
		current_state.queue_free()
	current_state = ball_state_factory.get_fresh_state(new_state)
	current_state.setup(self, player_detection_area)
	current_state.state_transition_requested.connect(switch_state)
	add_child.call_deferred(current_state)
	
# 发射
func shoot(shoot_direction : Vector2, shoot_power: float):
	# 速度设置
	velocity = shoot_direction * shoot_power
	switch_state(State.SHOT)
