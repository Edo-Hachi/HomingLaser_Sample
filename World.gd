extends Node3D

var PosMarkerObj = preload("res://PosMarker.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		print("press")
		CreateCurve()
	
	pass

func CreateCurve():
	var curve = Curve3D.new()

	curve.clear_points()
	
	var StartCtrl = $StartHandle.position - $StartPoint.position 
	var EndCtrl = $EndHandle.position - $EndPoint.position 
	
	curve.bake_interval = 5	#smaller Number Create More Efficient
	#curve.bake_interval = 2
	
	curve.add_point($StartPoint.position, Vector3.ZERO, StartCtrl)
	curve.add_point($EndPoint.position, EndCtrl, Vector3.ZERO)


	var p2 = Vector3.ZERO
	for p in curve.get_baked_points():
		#var angle : float = 0.1
		if p2 == Vector3.ZERO: #Skip the First Loop
			p2 = p
			continue
			
		var velocity = (p2 - p)
			
		var PosMark = PosMarkerObj.instantiate()
		PosMark.position = p
		PosMark.rotation.y = atan2(velocity.x, velocity.z) #Object Rotate
		
		p2 = p
		get_parent().add_child(PosMark)
	
