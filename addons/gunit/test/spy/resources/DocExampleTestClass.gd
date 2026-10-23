# The class 'TestClass' used by the examples of the spy documentation page
extends Node

var _value: int


func message() -> String:
	return "a message"


func set_value(value: int) -> void:
	_value = value
