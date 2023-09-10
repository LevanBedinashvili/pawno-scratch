	AutoShopText[0] = TextDrawCreate(527.000000, 230.000000, "<<");
	TextDrawLetterSize(AutoShopText[0], 0.220000, 1.199999);

	AutoShopText[1] = TextDrawCreate(581.000000, 230.000000, ">>");
	TextDrawLetterSize(AutoShopText[1], 0.220000, 1.199999);

	AutoShopText[2] = TextDrawCreate(581.000000, 271.000000, ">");
	TextDrawLetterSize(AutoShopText[2], 0.220000, 0.599999);

	AutoShopText[3] = TextDrawCreate(581.000000, 281.000000, ">");
	TextDrawLetterSize(AutoShopText[3], 0.220000, 0.599999);

	AutoShopText[4] = TextDrawCreate(527.000000, 281.000000, "<");
	TextDrawLetterSize(AutoShopText[4], 0.220000, 0.599999);

	AutoShopText[5] = TextDrawCreate(527.000000, 271.000000, "<");
	TextDrawLetterSize(AutoShopText[5], 0.220000, 0.599999);

	for(new s; s < 6; s++)
	{
	    TextDrawTextSize(AutoShopText[s], 10.10, 40.40);
		TextDrawAlignment(AutoShopText[s], 2);
		TextDrawBackgroundColor(AutoShopText[s], 255);
		TextDrawFont(AutoShopText[s], 2);
		TextDrawColor(AutoShopText[s], -1);
		TextDrawSetProportional(AutoShopText[s], 1);
		TextDrawSetShadow(AutoShopText[s], 1);
		TextDrawUseBox(AutoShopText[s], 1);
		TextDrawBoxColor(AutoShopText[s], 555819392);
		TextDrawSetSelectable(AutoShopText[s],true);
	}

	AutoShopText[6] = TextDrawCreate(556.000000, 311.000000, "BUY");
	TextDrawLetterSize(AutoShopText[6], 0.450000, 0.899999);
	TextDrawBoxColor(AutoShopText[6], 144);
	TextDrawTextSize(AutoShopText[6], 10.10, 56.56);
	TextDrawSetSelectable(AutoShopText[6], 1);

	AutoShopText[7] = TextDrawCreate(556.000000, 331.000000, "EXIT");
	TextDrawLetterSize(AutoShopText[7], 0.450000, 0.899999);
	TextDrawBoxColor(AutoShopText[7], 144);
	TextDrawTextSize(AutoShopText[7], 10.10, 56.56);
	TextDrawSetSelectable(AutoShopText[7],true);

	AutoShopText[8] = TextDrawCreate(554.000000, 161.000000, "_");// ???
	TextDrawLetterSize(AutoShopText[8], 0.500000, 22.200017);
	TextDrawSetProportional(AutoShopText[8], 1);
	TextDrawBoxColor(AutoShopText[8], 1128481664);
	TextDrawTextSize(AutoShopText[8], 0.000000, 105.000000);

	for(new e = 6; e < 9; e++)
	{
		TextDrawAlignment(AutoShopText[e], 2);
		TextDrawBackgroundColor(AutoShopText[e], 255);
		TextDrawFont(AutoShopText[e], 1);
		TextDrawColor(AutoShopText[e], -1);
		TextDrawSetProportional(AutoShopText[e], 1);
		TextDrawSetShadow(AutoShopText[e], 1);
		TextDrawUseBox(AutoShopText[e], 1);
	}

	AutoShopText[9] = TextDrawCreate(522.000000, 211.000000, "SELECT CAR");
	AutoShopText[10] = TextDrawCreate(537.000000, 251.000000, "COLOR");
	AutoShopText[11] = TextDrawCreate(541.000000, 165.000000, "Choose");

	for(new r = 9; r < 12; r++)
	{
		TextDrawBackgroundColor(AutoShopText[r], 255);
		TextDrawFont(AutoShopText[r], 2);
		TextDrawSetOutline(AutoShopText[r], 0);
		TextDrawSetShadow(AutoShopText[r], 0);
		TextDrawLetterSize(AutoShopText[r], 0.260000, 1.300000);
		TextDrawColor(AutoShopText[r], -2016477185);
		TextDrawSetProportional(AutoShopText[r], 1);
	}