<?php
	function pushWorkOrder() {
		include 'customer.php';
		include 'filter.php';
		
		if (!checkCustExists($clean))
			sendCustInfo($clean);
		
		sendWorkOrderInfo($clean);
	}
	
	function sendWorkOrderInfo(&$clean) {
		include 'loginCapstone.php';
		
		mysqli_query($con, "insert into WorkOrderData (open, tune, workid, custid, bikeid) values ('" . $clean[open] . "','" . $clean[tune] . "',UNHEX(REPLACE(UUID(), '-', '')),'" . $clean[custid] . "', UNHEX(REPLACE(UUID(), '-', '')));");
		
		getWorkID($clean);
		
		$string .= "insert into WorkOrderNotes (pre, post, workid) values ('". $clean[pre] . "','" . $clean[post] . "',UNHEX(REPLACE(UUID(), '-', '')));";
		
		if (!mysqli_multi_query($con, $string))
			print(mysqli_connect_error());

		mysqli_close();
	}
	
	function getWorkID(&$clean)
	{
		include 'loginCapstone.php';
		
		// Get the customer's handle
		$guid = mysqli_query($con, "select HEX(workid) from CustData where open='" . $clean[open] . "' and tune='" . $clean[lname] . "' and address='" . $clean[address] . "' and city='" . $clean[city] . "' and phone='" . $clean[phone] . "' and email='" . $clean[email] . "';");
		if (mysqli_num_rows($guid) < 1)
		{
			// Customer is not found
			/* Options:
				- send the data
				- return failure
				*/
			print("Customer not found");
			return "";
		}
		else if (mysqli_num_rows($guid) > 1)
		{
			print("Multiple customers..."); // This should not happen
		}
		
		$row = mysqli_fetch_assoc($guid);
		
		foreach ($row as $cname => $cvalue)
			$clean[custid] = $cvalue;
	}
?>