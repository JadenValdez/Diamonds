This is a small project based on a puzzle game. The goal is to figure out the correct weights of the colored blocks 
using a scale. This was originally meant for a 2-player game, although it is possible to play single player as well.


New Single Player Rules:
	There are 7 colored blocks (Red, Orange, Yellow, Green, Blue, Indigo, and Violet) each with a unique integer weight 
	from 1g to 8g that is randomized each game. Exactly one weight will not be used.
	
	Using the scale, the player can weigh any combination of colored blocks against any other combination of colored blocks
	without reusing any blocks within a single weighing. (ex. Red vs Orange is a valid weighing. Yellow vs Violet + Blue 
	is also valid.) They will then recieve the result of the weighing (Left Side Heavier, Right Side Heavier, or Equal)/
	Once the Player believes they know the weights of all seven blocks, they will submit their answer. If they are 
	correct, they win! If not, they lose. The goal is to achieve victory in as few weighings as possible.


Original 2 Player Rules:
	There are 7 colored blocks (Red, Orange, Yellow, Green, Blue, Indigo, and Violet) each with a unique integer weight 
	from 1g to 8g that is randomized each game. Exactly one weight will not be used.
	
	Player 1 will choose a weight and be secretly told its corresponding colored block (or None if it does not 
	correspond to any). Player 2 will then choose two weights that haven't been chosen yet, and finally Player 1 will 
	choose one last weight of the remaining choices.
	
	Starting with Player 1, turns will alternate between the players. A player must Weigh on their turn, and then can 
	optionally choose to Answer. The player can choose to Pass instead of Answering. Each player gets 3 minutes on their
	turn, with an additional 5 minutes of reserve time which is not replenished. If a player uses up their 3 minutes, then
	they will start using their reserve time. If a player uses up all their reserve time, they lose the game.
	
	Weigh:
		The Player chooses to weigh any combination of colored blocks against any other combination of colored blocks
		without reusing any blocks within a single weighing. (ex. Red vs Orange is a valid weighing. Yellow vs 
		Violet + Blue is also valid.) Both players will be told the result of the weighing (Left Side Heavier, Right Side 
		Heavier, or Equal)
		
	Answer:
		The Player must correctly guess the weights of all 7 colored blocks. If they are correct, they win the game. If 
		they are incorrect, then they obtain a penalty. A Player who obtains two penalties immediately loses, and the 
		other player will be the winner.
		
	Pass:
		If they choose not to Answer, then the Player must Pass. Their time will continue to dwindle down until they 
		actually express their intent to Pass.
