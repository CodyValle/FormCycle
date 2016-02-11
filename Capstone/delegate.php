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

  include_once 'regexes.php';
	include_once 'DebugMessage.php';
	include_once 'ReturnString.php';
  
	include_once 'debug.php';
	include_once 'error.php';
	include_once 'loginCapstone.php';
	include_once 'filter.php';
	
	// Checks to see if the request is POST.
	if (!($_SERVER['REQUEST_METHOD'] === 'POST')) $GLOBALS['ERROR']->reportErrorCode("POST", true);
	
	// Successful run?
	$ret = false;
	
	// Checks whether 'action' is set and is using allowed characters.
	if (isset($_POST['action']) && isAlphaNumeric($_POST['action']))
	{
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
			//if (!$ret && $GLOBALS['DEBUG'])
				//print("No customer found with that information.");
			break;
			
		case "workUpdate":
			// Update a work order
			include 'workOrder.php';
			$wo = new WorkOrder;
			$ret = $wo->updateOrder($clean['workid'], $clean['open']);
			break;
			
		case "workSearch":
			// Searches through work orders and returns a JSON of the results.
			include 'workOrder.php';
			$wo = new WorkOrder;
			$ret = $wo->searchForWorkOrder($clean);
			//if (!$ret && $GLOBALS['DEBUG'])
				//print("No work orders found with that information.");
			break;
			
		case "bikeSearch":
			// Searches through work orders and returns a JSON of the results.
			include 'bike.php';
			$bike = new Bike;
			$ret = $bike->searchForBike($clean);
			//if (!$ret && $GLOBALS['DEBUG'])
				//print("No work orders found with that information.");
			break;
		
		case "login":
			// Returns true if a user has entered the correct pin
			include 'login.php';
			$ret = Login::get($clean);
			break;
		
		case "register":
			// Returns true if a user has entered the correct pin
			include 'login.php';
			$ret = Login::push($clean);
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

	// Close the database connection
	if ($GLOBALS['con']) 
	{
		//if ($GLOBALS['DEBUG']) print("Closing mysql connection." . PHP_EOL);
		$GLOBALS['con']->close();
		$GLOBALS['con'] = false;
	}
	
	// Print the clean array and all debugging messages.
	if ($GLOBALS['DEBUG'])
	{
		// Get debug messages
		$str = $GLOBALS['DBGMSG']->getMessage();
		
		// Get parameter values
		$str .= "***DEBUG PARAMETER SECTION***" . PHP_EOL;
		
		foreach ($clean as $key => $val)
			$str .= $key . ": " . $val . PHP_EOL;
			
		$str .= "***END DEBUG PARAMETER SECTION***" . PHP_EOL;
		
		// Get reported errors
		$str .= $GLOBALS['ERROR']->getErrorString();
		
		// Put all to debug part of return string
		$GLOBALS['RETURN']->addData('debug', $str);
	}

	// Add run success value
	$GLOBALS['RETURN']->addData('success', $ret);
	
	// Prepare return string
	$toReturn = $GLOBALS['RETURN']->getReturn();
	
	// Write return string to log file
	$date = new DateTime();
	file_put_contents('/log/Capstone/' . $date->format('Y-m-d_H:i:s') . '.txt', $toReturn);
	
	// Print return string and exit
	print($GLOBALS['RETURN']->getReturn());
?>