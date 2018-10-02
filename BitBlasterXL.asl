state("BitBlasterXL")
{
    //Written by David "BigMonD" Mulgrew
    //Timers starts on the first frame after loading.
    //Timer is reset on the loading screen just before starting.
    //Splits are for 5k, 10k, 15k, 20k and 25k points.
    //Splits are captured as soon as the score exceeds the required amount.
    
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
    vars.setGameReset = 0;
}
startup
{
	int[] comparison = {101010,151515,202020,252525,303030,353535,404040,454545,505050,555555,606060,656565,707070,757575,808080,858585,909090,959595,100100100,105105105,110110110,115115115,120120120,125125125};
	vars.compare = comparison;
	settings.Add("auto", true, "Automatic Splits");
	settings.Add("151515", true, "Score 5k", "auto");
	settings.Add("202020", false, "Score 10k", "auto");
	settings.Add("252525", false, "Score 15k", "auto");
	settings.Add("303030", false, "Score 20k", "auto");
	settings.Add("353535", false, "Score 25k", "auto");

}
start
{
    //print(current.gameState.ToString());
	return (current.gameState == 6);
}
reset
{
    if (vars.setGameReset == 1)
    {
        vars.setGameReset = 0;
        return true;
    }
    return false;
}
split
{
    //print(current.gameScore.ToString());
    
    if(current.gameScore >= 5000 && vars.passed5k == 0)
    {
        //If score exceeds 5000 and score threshholds has not already been passed
        vars.passed5k = 1;
        return true;
    }
    if(current.gameScore >= 10000 && vars.passed5k == 1 && vars.passed10k == 0)
    {
        //If score exceeds 10000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed10k = 1;
        return true;
    }
    if(current.gameScore >= 15000 && vars.passed10k == 1 && vars.passed15k == 0)
    {
        //If score exceeds 15000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed15k = 1;
        return true;
    }
    if(current.gameScore >= 20000 && vars.passed15k == 1 && vars.passed20k == 0)
    {
        //If score exceeds 20000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed20k = 1;
        return true;
    }
    if(current.gameScore >= 25000 && vars.passed20k == 1 && vars.passed25k == 0)
    {
        //If score exceeds 25000 and score threshholds has not already been passed. Also requires previous threshhold to be passed
        vars.passed25k = 1;
        return true;
    }
}

update
{
	print("Current Game State " + current.gameState.ToString());
    if(current.gameState == 0 && old.gameState == 0 || current.gameState == 2 && old.gameState == 2 || current.gameState == 3 && old.gameState == 3)
    {
        vars.setGameReset = 1;
    }
    if(current.gameScore == 0)
    {
        vars.passed5k = 0;
        vars.passed10k = 0;
        vars.passed15k = 0;
        vars.passed20k = 0;
        vars.passed25k = 0;
        vars.setGameReset = 0;
    }
}