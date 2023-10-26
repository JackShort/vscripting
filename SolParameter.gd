class_name SolParameter

var name := ""
var type :Global.SolType = Global.SolType.sol_uint256
var value = null

func _init(_name: String, _type: Global.SolType, _value: Variant = null):
    name = _name
    type = _type
    value = _value if _value else get_default_value(type)

func get_default_value(_type: Global.SolType):
    match _type:
        Global.SolType.sol_uint256:
            return 0
        Global.SolType.sol_bool:
            return false
