state("BitBlasterXL")
{
    //Written by David "BigMonD" Mulgrew
    //Timers starts on the first frame after loading.
    //Timer is reset on the loading screen just before starting.
    //Splits are for 5k, 10k, 15k, 20k and 25k points.
    // Also added 50k and 75k for future use.
    //Splits are captured as soon as the score exceeds the required amount.
    //Added additional debugging
    //Removed unnecessary code
    
    byte gameState : "UnityPlayer.dll", 0x0147ECD8, 0x50;
    int gameScore : "UnityPlayer.dll", 0x014C4CE0, 0x38, 0x60, 0x128, 0x4E8, 0x88;
}
init
{
	vars.passed5k = 0;
    vars.passed10k = 0;
    vars.passed15k = 0;
    vars.passed20k = 0;
    vars.passed25k = 0;
    vars.passed50k = 0;
    vars.passed75k = 0;
    
    //Score targets are listed here because they are easier to change for debugging
    vars.score1 = 5000;
    vars.score2 = 10000;
    vars.score3 = 15000;
    vars.score4 = 20000;
    vars.score5 = 25000;
    vars.score6 = 50000;
    vars.score7 = 75000;
}
startup
{
	settings.Add("auto", true, "Automatic Splits");
	settings.Add("5k", true, "Score 5k", "auto");
	settings.Add("10k", true, "Score 10k", "auto");
	settings.Add("15k", true, "Score 15k", "auto");
	settings.Add("20k", true, "Score 20k", "auto");
	settings.Add("25k", true, "Score 25k", "auto");
	settings.Add("50k", false, "Score 50k", "auto");
	settings.Add("75k", false, "Score 75k", "auto");
    
    settings.SetToolTip("auto", "Select which score threshholds to plit at");
    settings.SetToolTip("5k", "Enable splitting time at 5,000 points.");
    settings.SetToolTip("10k", "Enable splitting time at 10,000 points.");
    settings.SetToolTip("15k", "Enable splitting time at 15,000 points.");
    settings.SetToolTip("20k", "Enable splitting time at 20,000 points.");
    settings.SetToolTip("25k", "Enable splitting time at 25,000 points.");
    settings.SetToolTip("50k", "Enable splitting time at 50,000 points.");
    settings.SetToolTip("75k", "Enable splitting time at 75,000 points.");
    
}
start
{
    
    //print(current.gameState.ToString());
    if (current.gameState == 6)
    {
        print("Bit Blaster XL Starting, GS: " + current.gameState.ToString() + "###############");
        return true;
    }
    return false;
}
reset
{
    if (current.gameState == 0 || current.gameState == 2 || current.gameState == 3)
    {
        print("Bit Blaster XL Rsetting, GS: " + current.gameState.ToString() + "###############");
        return true;
    }
    return false;
}
split
{
    //print(current.gameScore.ToString());
    
    if(current.gameScore >= vars.score1 && vars.passed5k == 0 && settings["5k"])
    {
        print("Bit Blaster XL Splitting, GS: " + current.gameState.ToString() + "###############");
        //If score exceeds 5000 and score threshholds has not already been passed
        vars.passed5k = 1;
        return true;
    }
    if(current.gameScore >= vars.score2 && vars.passed5k == 1 && vars.passed10k == 0 && settings["10k"])
    {
        print("Bit Blaster XL Splitting, GS: " + current.gameState.ToString() + "###############");
        //If score exceeds 10000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed10k = 1;
        return true;
    }
    if(current.gameScore >= vars.score3 && vars.passed10k == 1 && vars.passed15k == 0 && settings["15k"])
    {
        print("Bit Blaster XL Splitting, GS: " + current.gameState.ToString() + "###############");
        //If score exceeds 15000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed15k = 1;
        return true;
    }
    if(current.gameScore >= vars.score4 && vars.passed15k == 1 && vars.passed20k == 0 && settings["20k"])
    {   
        print("Bit Blaster XL Splitting, GS: " + current.gameState.ToString() + "###############");
        //If score exceeds 20000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed20k = 1;
        return true;
    }
    if(current.gameScore >= vars.score5 && vars.passed20k == 1 && vars.passed25k == 0 && settings["25k"])
    {
        print("Bit Blaster XL Splitting, GS: " + current.gameState.ToString() + "###############");
        //If score exceeds 25000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed25k = 1;
        return true;
    }
    if(current.gameScore >= vars.score6 && vars.passed25k == 1 && vars.passed50k == 0 && settings["50k"])
    {
        print("Bit Blaster XL Splitting, GS: " + current.gameState.ToString() + "###############");
        //If score exceeds 50000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed50k = 1;
        return true;
    }
    if(current.gameScore >= vars.score7 && vars.passed50k == 1 && vars.passed75k == 0 && settings["75k"])
    {
        print("Bit Blaster XL Splitting, GS: " + current.gameState.ToString() + "###############");
        //If score exceeds 75000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed75k = 1;
        return true;
    }
}

update
{
	print("Bit Blaster XL Current Game State " + current.gameState.ToString());
    //if(current.gameState == 0)
    //{
    //    vars.setGameReset = 1;
    //}
    //if(current.gameState == 2 )
    //{
    //    vars.setGameReset = 1;
    //}
    //if(current.gameState == 3)
    //{
    //    vars.setGameReset = 1;
    //}
    if(current.gameScore == 0)
    {
        vars.passed5k = 0;
        vars.passed10k = 0;
        vars.passed15k = 0;
        vars.passed20k = 0;
        vars.passed25k = 0;
        vars.passed50k = 0;
        vars.passed50k = 0;
    }
}