extends CanvasLayer

var command = null

onready var anim_player = $AnimationPlayer
onready var title_bar = $TitleBar

func _ready():
	yield(get_tree().create_timer(0.25), "timeout")
	anim_player.play("toggle")
	anim_player.connect("animation_finished", self, "anim_finished")

func _on_Exit_pressed():
	anim_player.play_backwards("toggle")
	command = "Exit"

func anim_finished(anim_name):
	if anim_name == "toggle":
		if command == "Exit":
			get_tree().change_scene("res://source/Main/Main.tscn")
