<?php
	/*
	File: delegate.php
	Short: Delegates where to go upon a request.
	Long: When a POST request is received, it checks the variable 'action' for existence, then
	determines what to do using the value of 'action'.
	*/
	
	/* if started from commandline, wrap parameters to $_POST*/
	if ($_SERVER['REQUEST_METHOD'] === "CMDLINE")
	{
		parse_str($argv[1], $_POST);
		$_SERVER['REQUEST_METHOD'] = "POST";
	}
	
	include_once 'debug.php';
	include_once 'error.php';
	include_once 'loginCapstone.php';
	include_once 'regexes.php';
	include_once 'filter.php';
	
	// Checks to see if the request is POST.
	if (!($_SERVER['REQUEST_METHOD'] === 'POST')) $GLOBALS['ERROR']->reportErrorCode("POST", true);
	
	// Checks whether 'action' is set and is using allowed characters.
	if (isset($_POST['action']) && isAlphaNumeric($_POST['action']))
	{
		$ret = false;
		// Checks 'action' against multiple cases.
		switch ($_POST['action'])
		{
		case "workOrder":
			// Pushes a work order to the database.
			include 'workOrder.php';
			$wo = new WorkOrder;
			$ret = $wo->pushWorkOrder($clean);
			break;
			
		case "custSearch":
			// Searches for a customer and returns a JSON of the results.
			include 'customer.php';
			$cust = new Customer;
			$ret = $cust->searchForCustomer($clean);
			if (!$ret && $GLOBALS['DEBUG'])
				print("No customer found with that information.");
			break;
		
		case "junkData":
			// Drops the database, then recreates it.
			include 'JunkData/JunkData.php';
			$ret = true;
			break;
		
		case "clean":
			// Drops the database, then recreates it.
			include 'clean.php';
			$ret = true;
			break;
	
		default:
			// Invalid 'action'.
			$GLOBALS['ERROR']->reportErrorCode("ACT");
			break;
		}
		
		if (!$ret) $GLOBALS['ERROR']->reportErrorCode("ERR");
	}
	else $GLOBALS['ERROR']->reportErrorCode("INV");

	if ($GLOBALS['con']) 
	{
		if ($GLOBALS['DEBUG']) print("Closing mysql connection." . PHP_EOL);
		$GLOBALS['con']->close();
		$GLOBALS['con'] = false;
	}
	
	// Print the clean array and all associated values if debugging is turned on.
	if ($GLOBALS['DEBUG'])
	{
		print("***DEBUG PARAMETER SECTION***" . PHP_EOL);
		
		foreach ($clean as $key => $val)
			print($key . ": " . $val . PHP_EOL);
			
		print("***END DEBUG PARAMETER SECTION***" . PHP_EOL);
		
		$GLOBALS['ERROR']->printErrors();
	}
?>