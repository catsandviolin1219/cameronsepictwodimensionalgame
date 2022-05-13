extends Node2D\

func importLvlData():
	var settings = "width/height/bordertop/borderbottom/borderleft/borderright/bgcolorred/bgcolorgreen/bgcolorblue/timervalue".split("/")
	var blocks = "xpos/ypos/blocktype".split("/")
	var levelData = "0/15&1/15&2/1&3/1&4/1&5/1&6/255&7/0&8/0&9/0&[0/3&1/13&2/0]&[0/3&1/3&2/1]"
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
			print(x)
			if (block == false):
				x = x.rstrip("[")
			block = true
			print(x)
			if ("]" in i):
				block = false
				x = x.rstrip("]")
			var key = x.split("/")[0]
			var value = x.split("/")[1]
			blockData[blocks[int(key)]] = int(value)
			if ("]" in i):
				data["blocks"].append(blockData)
				blockData = {}
	print(data)

func _ready():
	importLvlData()