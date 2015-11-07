<?php
	include_once 'regexes.php';

	if (isset($_POST[action]) && isAlphaNumeric($_POST[action]))
	{
		switch ($_POST[action])
		{
		/*
		case "pushCustInfo":
			include 'pushCustInfo.php';
			pushCustInfo();
			break;
		*/	
		case "workOrder":
			include 'workOrder.php';
			sendWorkOrderInfo();
			break;
			
		case "merrillTest":
			print($_POST[pwd]);
			break;
		
		case "junky":
			include 'junkData.php';
			break;
		
		case "clean":
			include 'clean.php';
			break;
	
		default:
			die("ACT"); // Action not found.
			break;
		}
		
		if ($con) mysqli_close();
	}
	else print "INV"; // Action variable DNE
?>