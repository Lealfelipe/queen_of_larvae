extends Node

var heart = 3
var maxHeart = heart

func removeHeart():
	heart -= 1
	
func addHeart():
	if heart < 5:
		heart += 1

func resetGame():
	heart = 3
	maxHeart = heart
