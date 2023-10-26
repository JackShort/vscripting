class_name SolFunction

var name := ""
var inputs := {}
var outputs := {}

func _init(_name: String):
    name = _name

func _to_string():
    return "Function: " + name