settings = "width/height/bordertop/borderbottom/borderleft/borderright/bgcolorred/bgcolorgreen/bgcolorblue/timervalue".split("/")
blocks = "xpos/ypos/blocktype".split("/")
levelData = "0/15&1/15&2/1&3/1&4/1&5/1&6/255&7/0&8/0&9/0&[0/3&1/13&2/0]&[0/3&1/3&2/1]"
levelDataDict = {"blocks": []}
block = False
tempBlock = {}
for i in levelData.split("&"):
    if ("[" not in i and block == False):
        key = i.split("/")[0]
        value = i.split("/")[1]
        levelDataDict[settings[int(key)]] = int(value)
    else:
        x = i
        if (block == False):
            x = i[1:]
        block = True
        if ("]" in i):
            block = False
            x = i[:-1]
        key = x.split("/")[0]
        value = x.split("/")[1]
        tempBlock[blocks[int(key)]] = int(value)
        if ("]" in i):
            levelDataDict["blocks"].append(tempBlock)
            tempBlock = {}
print(f"{levelData}, {levelDataDict}")