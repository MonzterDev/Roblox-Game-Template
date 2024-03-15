return {
	Name = "AdjustBalance";
	Aliases = { "aB" };
	Description = "Adjust a player's balance.";
	Group = "Admin";
	Args = {
		{
			Type = "currency";
			Name = "Currency";
			Description = "";
		},
		{
			Type = "number";
			Name = "Amount of Clicks";
			Description = "The amount of Clicks to add or subtract from the Player";
		},
		{
			Type = "player";
			Name = "Player";
			Description = "The Player";
			Optional = true;
		},
	}
}
