extends Node3D
class_name Game

enum GameStatus {Playing, Paused}

signal status_changed(status: GameStatus)

@export var win_score: int = 11

@onready var ball: Ball = $Level/Ball
@onready var p1ScoreUI: ScoreUI = $Level/P1ScoreUI
@onready var p2ScoreUI: ScoreUI = $Level/P2ScoreUI
@onready var ui: CanvasLayer = $UserInterface
@onready var menuTitle: Label = $UserInterface/MainMenu/VBoxContainer/MenuTitle
@onready var playButton: Button = $UserInterface/MainMenu/VBoxContainer/VBoxContainer/PlayButton

static var _playing = true
static var playing: int:
	get:
		return _playing

func _on_p_1_score_area_body_entered(body: Node3D) -> void:
	if body is Ball:
		var new_score = p1ScoreUI.increase()

		body._destroy()

		if new_score >= win_score:
			_finish('Player 1')
		else:
			body._reset()

func _on_p_2_score_area_body_entered(body: Node3D) -> void:
	if body is Ball:
		var new_score = p2ScoreUI.increase()

		body._destroy()

		if new_score >= win_score:
			_finish('Player 2')
		else:
			body._reset()

func _finish(player_id: String) -> void:
	playButton.text = 'Play Again'
	menuTitle.text = "%s WON!" % player_id
	ui.visible = true
	status_changed.emit(GameStatus.Paused)

func _restart() -> void:
	p1ScoreUI._reset()
	p2ScoreUI._reset()
	ui.visible = false
	ball._reset()
	status_changed.emit(GameStatus.Playing)

func _quit() -> void:
	get_tree().quit()
