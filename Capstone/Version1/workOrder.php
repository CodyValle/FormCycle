<?php
	/*
	File: workOrder.php
	Short: Performs all needed functions that deal with work orders.
	Long: Able to add a work order to the database.
	*/
class WorkOrder
{
	/*
	Function: pushWorkOrder
	Descrip: Utilizes the $clean array to add a work order to the database.
	*/
	function pushWorkOrder()
	{
		include 'filter.php';
		include 'customer.php';
		include 'bike.php';
		
		$cust = new Customer;
		$bike = new Bike;
		
		// Sends customer information. Most importantly, adds custid to $clean.
		if (!$cust->sendCustInfo($clean))
			die("CST");
		// Sends bike information. Most importantly, add bikeid to $clean.
		if (!$bike->sendBikeInfo($clean))
			die("BIK");
		// Sends the work order information.
		if (!$this->sendWorkOrderInfo($clean))
			die("ORD");
		
		return true;
	}
	
	/*
	Function: sendWorkOrderInfo
	Param clean: Reference to the array of URL variables that have been checked for
	valid values.
	Descrip: Adds the work order information to the database.
	*/
	function sendWorkOrderInfo(&$clean)
	{
		include 'loginCapstone.php';
		
		// Using the values in the clean array, send a MySQL statement to insert
		// the work order into the WorkOrderData table.
		if (mysqli_query($con, "insert into WorkOrderData
								(open, workid, custid, bikeid)
								values
								('" . $clean['open'] . "',
								 UNHEX(REPLACE(UUID(),'-','')),
								 '" . $clean['custid'] . "',
								 '" . $clean['bikeid'] . "');"))
		{
			// Get the workid
			$guid = mysqli_query($con, "select workid from WorkOrderData where
										rowid='" . $con->insert_id . "';");
			
			// Put the workid into the clean array.
			// *****This code could use some cleaning up*******
			$row = mysqli_fetch_assoc($guid);
			
			foreach ($row as $cname => $cvalue)
				$clean['workid'] = $cvalue;
				
			// Push the work order notes into the WorkOrderNotes table
			if (!mysqli_query($con, "insert into WorkOrderNotes
									(pre, post, workid)
									values
									('" . $clean['pre'] . "',
									 '" . $clean['post'] . "',
									 '" . $clean['workid'] . "');"))
				die("WRKNOTES");
				
			return true;
		}

		print(mysqli_error($con));
		return false;
	}
	
	/*
	Function: addTune
	Param clean: Reference to the array of URL variables that have been checked for
	valid values.
	Param tune: ID of the tune to add to this work order.
	Descrip: Adds the work order ID and the tunr id to the WorkOrderXTune table.
	*/
	function addTune(&$clean, $tune)
	{
		include 'loginCapstone.php';
		
		if (!mysqli_query($con, "insert into WorkOrderXTune
								(workid, tune)
								values
								('" . $clean['workid'] . "',
								 '" . $tune . "');"))
			die("ADDTUNE");
			
	}
}
?>