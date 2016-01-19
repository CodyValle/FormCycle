<?php
	/*
	File: delegate.php
	Short: Delegates where to go upon a request.
	Long: When a POST request is received, it checks the variable 'action' for existence, then
	determines what to do using the value of 'action'.
	*/
	
	include_once 'regexes.php';
	// Checks to see if the request is POST.
	if (!($_SERVER['REQUEST_METHOD'] === 'POST')) die("POST");
	
	// Checks whether 'action' is set and is using allowed characters.
	if (isset($_POST[action]) && isAlphaNumeric($_POST[action]))
	{
		$ret = false;
		// Checks 'action' against multiple cases.
		switch ($_POST[action])
		{
		case "workOrder":
			// Pushes a work order to the database.
			include 'workOrder.php';
			$wo = new WorkOrder;
			$ret = $wo->pushWorkOrder();
			break;
		
		case "clean":
			// Drops the database, then recreates it.
			include 'clean.php';
			break;
	
		default:
			// Invalid 'action'.
			die("ACT"); // Action not found.
			break;
		}
		
		if ($con) mysqli_close();
		if ($ret) print("SUC");
		else print("ERR");
	}
	else print "INV"; // 'action' variable DNE
?>