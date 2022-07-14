extends Node2D

var levelData = "0/15&1/15&2/1&3/1&4/1&5/1&6/072&7/168&8/165&9/0&[0/128&1/128&2/0]&[0/128&1/512&2/3]"
##var levelData = "0/15&1/15&2/1&3/1&4/1&5/1&6/000&7/255&8/025&9/0&[0/3&1/13&2/0]&[0/3&1/3&2/1]"

func convertedLvlData(levelData):
	var settings = "width/height/bordertop/borderbottom/borderleft/borderright/bgcolorred/bgcolorgreen/bgcolorblue/timervalue".split("/")
	var blocks = "xpos/ypos/blocktype".split("/")
	var data = {"blocks": []}
	var block = false
	var blockData = {}
	
	for i in levelData.split("&"):
		if (!("[" in i) and block == false):
			var key = i.split("/")[0]
			var value = i.split("/")[1]
			data[settings[int(key)]] = int(value)
		else:
			var x = i
			if (block == false):
				x = x.rstrip("[")
			block = true
			if ("]" in i):
				block = false
				x = x.rstrip("]")
			var key = x.split("/")[0]
			var value = x.split("/")[1]
			blockData[blocks[int(key)]] = int(value)
			if ("]" in i):
				data["blocks"].append(blockData)
				blockData = {}
	return data

func createLevel(convertedLevelData):
	var bgcolor = Color(float(convertedLevelData["bgcolorred"])/255, float(convertedLevelData["bgcolorgreen"])/255, float(convertedLevelData["bgcolorblue"])/255)
	print(bgcolor)
	$background.modulate = bgcolor
	for i in (convertedLevelData["blocks"]):
		var obj = load("res://Resources/obj/%s.tscn" % i["blocktype"])
		var instance = obj.instance()
		instance.position = Vector2(i["xpos"], i["ypos"])
		add_child(instance)

func _ready():
	var convertedLevelData = convertedLvlData(levelData)
	print(convertedLevelData)
	createLevel(convertedLevelData)