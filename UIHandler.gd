class_name UIHandler
extends CanvasLayer

var data: Dictionary:
    set(v):
        if data != v:
            data = v
            dirty = true

var dirty: bool

func _enter_tree() -> void:
    var cs = get_tree().current_scene
    cs.child_entered_tree.connect(_listen)

func _update_all_ui(): if dirty: propagate_call("_update_ui", [data])

func _listen(node: Node):
    if not has_signal("submit_update"): return
    node.submit_update.connect(_submit_data)

func _submit_data(key: String, value: Variant): data[key] = value
