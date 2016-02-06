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
		if ($clean['tagNum'] !== NULL)
			$cmd->addParameter('tagid', $clean['tagNum']);

		if ($GLOBALS['con']->query($cmd->getSQL()))
		{
			// Get the workid
			$sel = new MySQLSelectCommand("WorkOrderData");
			$sel->addColumn("HEX(workid) AS workid");
			$sel->addParameter('rowid', $GLOBALS['con']->insert_id);
			
			$guid = $GLOBALS['con']->query($sel->getSQL());
			
			// Put the workid into the clean array.
			$clean['workid'] = $guid->fetch_assoc()['workid'];
			
			// Close SELECT results
			$guid->close();
				
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
	
	function searchForWorkOrder(&$clean)
	{
		// Creates a new MYSQLSelectCommand to select data from the 'WorkOrderData' table.
		$cmd = new MYSQLSelectCommand('WorkOrderData as w');
		$cmd->addJoin("CustData as c", "(c.custid = w.custid)");
		$cmd->addJoin("WorkOrderNotes as o", "(o.workid = w.workid)");
		$cmd->addJoin("BikeData as b", "(b.bikeid = w.bikeid)");
		$cmd->addJoin("BikeNoteData as n", "(b.bikeid = n.bikeid)");
		
		$cmd->addColumn("HEX(w.workid) as workid");
		$cmd->addColumn("HEX(c.custid) as custid");
		$cmd->addColumn("HEX(b.bikeid) as bikeid");
		
		$cmd->addColumn('c.fname as fname');
		$cmd->addColumn('c.lname as lname');
		$cmd->addColumn('c.address as address');
		$cmd->addColumn('c.address2 as address2');
		$cmd->addColumn('c.city as city');
		$cmd->addColumn('c.state as state');
		$cmd->addColumn('c.country as country');
		$cmd->addColumn('c.zip as zip');
		$cmd->addColumn('c.phone as phone');
		$cmd->addColumn('c.email as email');

		$cmd->addColumn('b.brand as brand');
		$cmd->addColumn('b.model as model');
		$cmd->addColumn('b.color as color');
		
		$cmd->addColumn('n.notes as notes');
		
		$cmd->addColumn('w.tagid as tagnum');
		$cmd->addColumn('w.createtime as createtime');
		
		$cmd->addColumn('o.pre as pre');
		$cmd->addColumn('o.post as post');
		
		if ($clean['workid'] !== NULL)
			$cmd->addParameter('w.workid', "UNHEX(" . $clean['workid'] . ")", false);
		if ($clean['open'] !== NULL)
			$cmd->addParameter('w.open', $clean['open'], true);
		if ($clean['fname'] !== NULL)
			$cmd->addParameter('c.fname', $clean['fname'], true);
		if ($clean['lname'] !== NULL)
			$cmd->addParameter('c.lname', $clean['lname'], true);
		if ($clean['phone'] !== NULL)
			$cmd->addParameter('c.phone', $clean['phone'], true);
		if ($clean['email'] !== NULL)
			$cmd->addParameter('c.email', $clean['email'], true);
		if ($clean['date'] !== NULL)
			$cmd->addParameter('date(w.createtime)', $clean['date']);
		
		// Sends the query and stores the result.
		$results = $GLOBALS['con']->query($cmd->getSQL(' ORDER BY w.rowid DESC'));
		if (!is_object($results))
			return false;

		// Prepare an array to hold the results and become a JSON string
		$jsonArray = array();
		while($row = $results->fetch_array(MYSQL_ASSOC))
			$jsonArray[] = $row;

		// Encode and print the JSON string
		$GLOBALS['RETURN']->addData('return', json_encode($jsonArray));
		
		// Close the query results
		$results->close();
		
		// Successful operation
		return true;
	}
}
?>