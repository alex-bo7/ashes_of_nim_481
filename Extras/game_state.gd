extends Node
class_name GameState

var to_move: GameManager.turn
var utility: int
var board: Array
var moves: Array

func _init(to_move:GameManager.turn, utility:int, board:Array, moves:Array) -> void:
	self.to_move = to_move
	self.utility = utility
	self.board = board
	self.moves = moves
