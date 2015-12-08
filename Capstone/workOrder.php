<?php
	/*
	File: workOrder.php
	Short: Performs all needed functions that deal with work orders.
	Long: Able to add a work order to the database.
	*/
	
	include_once 'MySQLCommand.php';
	
class WorkOrder
{
	/*
	Function: pushWorkOrder
	Descrip: Utilizes the $clean array to add a work order to the database.
	*/
	function pushWorkOrder(&$clean)
	{
		include 'customer.php';
		include 'bike.php';
		
		$cust = new Customer;
		$bike = new Bike;
		
		// Sends customer information. Most importantly, adds custid to $clean.
		if (!$cust->sendCustInfo($clean))
		{
			$GLOBALS['ERROR']->reportErrorCode("CST");
			return false;
		}
		
		// Sends bike information. Most importantly, add bikeid to $clean.
		if (!$bike->sendBikeInfo($clean))
		{
			$GLOBALS['ERROR']->reportErrorCode("BIK");
			return false;
		}
		
		// Sends the work order information.
		if (!$this->sendWorkOrderInfo($clean))
		{
			$GLOBALS['ERROR']->reportErrorCode("ORD");
			return false;
		}
		
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
		// Using the values in the clean array, send a MySQL statement to insert
		// the work order into the WorkOrderData table.
		$cmd = new MySQLInsertCommand("WorkOrderData");
		$cmd->addID('workid');
		if ($clean['open'] !== NULL)
			$cmd->addParameter('open', $clean['open']);
		if ($clean['custid'] !== NULL)
			$cmd->addParameter('custid', "UNHEX('" . $clean['custid'] . "')", false);
		if ($clean['bikeid'] !== NULL)
			$cmd->addParameter('bikeid', "UNHEX('" . $clean['bikeid'] . "')", false);
		if ($clean['tagid'] !== NULL)
			$cmd->addParameter('tagid', $clean['tagid']);
		
		
		if ($GLOBALS['con']->query($cmd->getSQL()))
		{
			// Get the workid
			$sel = new MySQLSelectCommand("WorkOrderData");
			$sel->addColumn("HEX(workid) AS workid");
			$sel->addParameter('rowid', $GLOBALS['con']->insert_id);
			
			$guid = $GLOBALS['con']->query($sel->getSQL());
			
			// Put the workid into the clean array.
			$clean['workid'] = $guid->fetch_assoc()['workid'];
				
			// Insert notes data
			return $this->insertWorkNotes($clean);
		}

		$GLOBALS[ERROR]->reportErrorCode("WRKIN");
		return false;
	}
	
	/*
	Function: insertWorkNotes
	Param clean: The clean array with all of the variables to be put into the database.
	Descrip: Inserts notes about the work order into the database.
	*/
	function insertWorkNotes(&$clean)
	{
		// Creates a new MYSQLInsertCommand to insert data into the 'BikeData' table.
		$cmd = new MYSQLInsertCommand('WorkOrderNotes');
		if ($clean['workid'] !== NULL)
			$cmd->addParameter("workid", "UNHEX('" . $clean['workid'] . "')", false);
		if ($clean['pre'] !== NULL)
			$cmd->addParameter('pre', $clean['pre']);
		if ($clean['post'] !== NULL)
			$cmd->addParameter('post', $clean['post']);
		
		if (!$GLOBALS['con']->query($cmd->getSQL()))
		{
			$GLOBALS['ERROR']->reportErrorCode("WRKNOT");
			$GLOBALS['ERROR']->reportError("WRKNOT" . $clean['workid'], $cmd->getSQL());
			return false;
		}
		
		return true;
	}
	
	/*
	Function: addTune
	Param clean: Reference to the array of URL variables that have been checked for
	valid values.
	Param tune: ID of the tune to add to this work order.
	Descrip: Adds the work order ID and the tunr id to the WorkOrderXTune table.
	*/
	function addTune($workid, $tune)
	{
		// Create an insert command
		$cmd = new MySQLInsertCommand("WorkOrderXTune");
		$cmd->addParameter("workid", "UNHEX('" . $workid . "')", false);
		$cmd->addParameter("tune", $tune);
		
		if (!$GLOBALS['con']->query($cmd->getSQL()))
		{
			$GLOBALS[ERROR]->reportErrorCode("ADDTUNE");
			return false;
		}
		
		return true;
	}
}
?>