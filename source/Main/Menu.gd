extends CanvasLayer

var command = null

onready var anim_player = $AnimationPlayer
onready var buttons = $Buttons
onready var tween = $Tween

func _ready():
	yield(get_tree().create_timer(0.25), "timeout")
	anim_player.play("toggle")
	anim_player.connect("animation_finished", self, "anim_finished")
	for button in buttons.get_children():
		button.connect("pressed", self, "button_pressed", [button.name])
		button.connect("mouse_entered", self, "mouse_hover_button", [button.name, true])
		button.connect("mouse_exited", self, "mouse_hover_button", [button.name, false])

func anim_finished(_anim_name):
	if command == "Exit":
		get_tree().quit()

func button_pressed(button_name):
	command = button_name
	anim_player.play_backwards("toggle")

func mouse_hover_button(button_name, is_starting):
	if buttons.has_node(button_name):
		var button = buttons.get_node(button_name)
		var start_value = button.rect_position.x
		var end_value = 0
		var duration = 0.1
		if is_starting: end_value = 32
		tween.interpolate_property(
			button, "rect_position:x", start_value, end_value, duration,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		tween.start()
