<?php
	/*
	File: debug.php
	Short: Turns on the debugging variable.
	Long: If a URL variable is named 'DEBUG' and its value is 'true', then 
	the system will print out a lot more data.
	*/
	
	// For debugging, I think.
	if (isset($_POST['DEBUG']) && $_POST['DEBUG'] === "true")
	{
		$GLOBALS['DEBUG'] = true;
		//print("&&&&& DEBUG MODE IS ON &&&&&" . PHP_EOL);
	}
	else $GLOBALS['DEBUG'] = false;
?>