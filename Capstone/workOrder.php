<?php
	/*
	File: workOrder.php
	Short: Performs all needed functions that deal with work orders.
	Long: Able to add a work order to the database.
	*/
	
	/*
	Function: pushWorkOrder
	Descrip: Utilizes the $clean array to add a work order to the database.
	*/
	function pushWorkOrder()
	{
		include 'filter.php';
		include 'customer.php';
		include 'bike.php';
		
		// Sends customer information. Most importantly, adds custid to $clean.
		if (!sendCustInfo($clean))
			die("CST");
		// Sends bike information. Most importanlty, add bikeid to $clean.
		if (!sendBikeInfo($clean))
			die("BIK");
		// Sends the work order information.
		if (sendWorkOrderInfo($clean))
			die("ORD");
	}
	
	/*
	Function: sendWorkOrderInfo
	Descrip: Adds the work order information to the database.
	*/
	function sendWorkOrderInfo(&$clean)
	{
		include 'loginCapstone.php';
		
		// Using the values in the clean array, send a MySQL statement to insert
		// the work order into the WorkOrderData table.
		if (mysqli_query($con, "insert into WorkOrderData
								(open, tune, workid, custid, bikeid)
								values
								('" . $clean['open'] . "',
								 '" . $clean['tune'] . "',
								 UNHEX(REPLACE(UUID(),'-','')),
								 '" . $clean['custid'] . "',
								 '" . $clean['bikeid'] . "');"))
		{
			// Get the workid
			$guid = mysqli_query($con, "select workid from WorkOrderData where
										rowid='" . $con->insert_id . "';");
			
			// Put the workid into the clean array.
			// *****This code could use som ecleaning up*******
			$row = mysqli_fetch_assoc($guid);
			
			foreach ($row as $cname => $cvalue)
				$clean['workid'] = $cvalue;
				
			// Push the work order notes into the WorkOrderNotes table
			if (!mysqli_query($con, "insert into WorkOrderNotes
									(pre, post, workid)
									values
									('". $clean['pre'] . "',
									 '" . $clean['post'] . "',
									 '" . $clean['workid'] . "');"))
				die("WRK");
				
			return true;
		}

		return false;
	}
?>