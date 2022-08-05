extends Area2D

var moveSpeed = 32
var velocity = Vector2(0, 0)
var jumpSpeed = 64
var accel = 3

var counterMovement = 128 ## only on ground
var counterThreshold = 2
var zeroMovementThreshold = 2

var holdingKey = false

var move = Vector2(0, 0)

func _process(delta):
	if (Input.is_action_pressed("ui_left")):
		holdingKey = true
		if (Input.is_action_pressed("ui_right")):
			holdingKey = false
			move.x = 0
		else:
			if (-velocity.x < moveSpeed):
				move.x = -(moveSpeed * delta * accel)
				if (-velocity.x + -move.x > moveSpeed):
					move.x = 0
			else:
				move.x = -(velocity.x) - moveSpeed
	elif (Input.is_action_pressed("ui_right")):
		holdingKey = true
		if (velocity.x < moveSpeed):
			move.x = moveSpeed * delta * accel
			if (velocity.x + move.x > moveSpeed):
				move.x = 0
		else:
			move.x = -(velocity.x) + moveSpeed
	else:
		holdingKey = false
		if (velocity.x != 0):
			if (velocity.x < -counterThreshold):
				move.x = counterMovement * delta
			elif (velocity.x > counterThreshold):
				move.x = -counterMovement * delta
			else:
				move.x = -velocity.x
	if (((velocity.x < -zeroMovementThreshold) or (velocity.x > zeroMovementThreshold)) or holdingKey):
		velocity.x = velocity.x + move.x
	else:
		velocity.x = 0
	velocity.y = velocity.y + (gravity * delta * 2/3)
	position = position + velocity

func collide_obj(area_id, area, area_shape, self_shape):
	var otherCollision = self.shape_owner_get_owner(area_shape)
	var hitboxTypeOther = otherCollision.name
	var selfCollision = self.shape_owner_get_owner(self_shape)
	var hitboxTypeSelf = selfCollision.name
	print("Other: " + hitboxTypeOther + " Self: " + hitboxTypeSelf)
	if (hitboxTypeOther == "hitboxes-collide" and hitboxTypeSelf == "hitboxes-collide"):
		var otherShape = otherCollision.shape
		var selfShape = selfCollision.shape
		var contacts = otherShape.collide_and_get_contacts(otherCollision.transform, selfShape, selfCollision.transform)
		print(contacts)
		if (contacts != []):
			var toMove = Vector2(0, 0)
			for i in range(contacts.size()/2):
				var moveNormal = (contacts[i + 1] - contacts[i]).normalized()
				var moveDepth = (contacts[i + 1] - contacts[i]).length()
				toMove = toMove + (moveNormal * moveDepth)
			position = position - toMove
			velocity.y = -1
		else:
			print("<!> SUS ALERT <!>")
	else:
		print("Collision ignored due to incorrect hitbox type")
