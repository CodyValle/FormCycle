<?php
	/*
	File: customer.php
	Short: Deals with all customer data interaction.
	Long: Contains functions to check whether the customer already exists in the
	database and adds them to the database.
	*/
	include_once 'MySQLCommand.php';
	
class Customer
{
	/*
	Function: custExists
	Param clean: Reference to the array of URL variables that have been checked for
	valid values.
	Descrip: Uses the variable values passed in to find an identical record. The
	function returns true if a record is found.
	*/
	function custExists(&$clean)
	{
		// Creates a new MYSQLSelectCommand to select data from the 'CustData' table.
		$cmd = new MYSQLSelectCommand('CustData');
		$cmd->addColumn("HEX(custid) AS custid");
		if ($clean['fname'] !== NULL)
			$cmd->addParameter('fname', $clean['fname']);
		if ($clean['lname'] !== NULL)
			$cmd->addParameter('lname', $clean['lname']);
		if ($clean['address'] !== NULL)
			$cmd->addParameter('address', $clean['address']);
		if ($clean['address2'] !== NULL)
			$cmd->addParameter('address2', $clean['address2']);
		if ($clean['city'] !== NULL)
			$cmd->addParameter('city', $clean['city']);
		if ($clean['state'] !== NULL)
			$cmd->addParameter('state', $clean['state']);
		if ($clean['country'] !== NULL)
			$cmd->addParameter('country', $clean['country']);
		if ($clean['zip'] !== NULL)
			$cmd->addParameter('zip', $clean['zip']);
		if ($clean['phone'] !== NULL)
			$cmd->addParameter('phone', $clean['phone']);
		if ($clean['email'] !== NULL)
			$cmd->addParameter('email', $clean['email']);
		
		// Sends the query and stores the result.
		$test = $GLOBALS['con']->query($cmd->getSQL());
		if (!is_object($test))
		{
			$GLOBALS['ERROR']->reportErrorCode("CSTSL");
			$GLOBALS['ERROR']->reportError("CSTSL" . $clean['fname'] . $clean['lname'], $cmd->getSQL());	
			return false;
		}
		
		// Checks whether a record was found.
		if ($test->num_rows < 1)
			return false;

		// Gets the customer ID from the returned record and stores it in the clean array.
		$clean['custid'] = $test->fetch_assoc()['custid'];
		
		// Close SELECT results
		$test->close();

		// Success.
		return true;
	}

	/*
	Function: sendCustInfo
	Param clean: Reference to the array of URL variables that will be inserted into
	the database.
	Descrip: Uses the clean array to create a new customer record in the database.
	*/
	function sendCustInfo(&$clean)
	{
		// Check if there exists a customer with this information.
		if ($this->custExists($clean))
			return true;
		
		// Creates a new MYSQLInsertCommand to insert data into the 'CustData' table.
		$cmd = new MYSQLInsertCommand('CustData');
		$cmd->addID('custid');
		if ($clean['fname'] !== NULL)
			$cmd->addParameter('fname', $clean['fname']);
		if ($clean['lname'] !== NULL)
			$cmd->addParameter('lname', $clean['lname']);
		if ($clean['address'] !== NULL)
			$cmd->addParameter('address', $clean['address']);
		if ($clean['address2'] !== NULL)
			$cmd->addParameter('address2', $clean['address2']);
		if ($clean['city'] !== NULL)
			$cmd->addParameter('city', $clean['city']);
		if ($clean['state'] !== NULL)
			$cmd->addParameter('state', $clean['state']);
		if ($clean['country'] !== NULL)
			$cmd->addParameter('country', $clean['country']);
		if ($clean['zip'] !== NULL)
			$cmd->addParameter('zip', $clean['zip']);
		if ($clean['phone'] !== NULL)
			$cmd->addParameter('phone', $clean['phone']);
		if ($clean['email'] !== NULL)
			$cmd->addParameter('email', $clean['email']);

		// Send the query
		if ($GLOBALS['con']->query($cmd->getSQL()))
		{
			// If the insert was successful,
			// create a new MYSQLSelectCommand to retrieve the customer's handle.
			$sel = new MYSQLSelectCommand('CustData');
			$sel->addColumn("HEX(custid) AS custid");
			$sel->addParameter('rowid', $GLOBALS['con']->insert_id);
			
			$guid = $GLOBALS['con']->query($sel->getSQL());
			if (!is_object($guid))
			{
				$GLOBALS['ERROR']->reportErrorCode("CSTRW");
				$GLOBALS['ERROR']->reportError("CSTSRW" . $clean['fname'] . $clean['lname'], $sel->getSQL());	
				return false;
			}
			
			// Add the handle to the global clean array.
			$clean['custid'] = $guid->fetch_assoc()['custid'];
			
			return true;
		}
		
		// Rudimentary email duplicate test.
		$out = $this->testEmail($clean);
		if ($out !== NULL)
		{
			$GLOBALS['ERROR']->reportError("EMAIL" . $clean['fname'] . $clean['lname'], $out);
		}

		// The insert failed. Report it and try to move on.
		$GLOBALS['ERROR']->reportErrorCode("CSTIN");
		$GLOBALS['ERROR']->reportError("CSTIN" . $clean['fname'] . $clean['lname'], $cmd->getSQL());
		return false;
	}
	
	function testEmail(&$clean)
	{
		// Creates a new MYSQLSelectCommand to check if this email is in the 'CustData' table.
		$cmd = new MYSQLSelectCommand('CustData');
		$cmd->addColumn("HEX(custid) as 'Customer ID'");
		//$cmd->addColumn("fname as 'First Name'");
		//$cmd->addColumn("lname as 'Last Name'");
		//$cmd->addColumn("address as 'Address'");
		//$cmd->addColumn("phone as 'Phone Number'");
		if ($clean['email'] !== NULL)
			$cmd->addParameter('email', $clean['email']);
		
		// Sends the query and stores the result.
		$test = $GLOBALS['con']->query($cmd->getSQL());
		
		// Checks whether a record was found.
		if ($test->num_rows > 1)
			return $cmd->getSQL();
		
		return NULL;
	}
	
	function searchForCustomer(&$clean)
	{
		// Creates a new MYSQLSelectCommand to select data from the 'CustData' table.
		$cmd = new MYSQLSelectCommand('CustData');
		$cmd->addColumn("HEX(custid) as custid");
		$cmd->addColumn('fname');
		$cmd->addColumn('lname');
		$cmd->addColumn('address');
		$cmd->addColumn('address2');
		$cmd->addColumn('city');
		$cmd->addColumn('state');
		$cmd->addColumn('country');
		$cmd->addColumn('zip');
		$cmd->addColumn('phone');
		$cmd->addColumn('email');
		if ($clean['fname'] !== NULL)
			$cmd->addParameter('fname', $clean['fname'] . '%', true, 'LIKE');
		if ($clean['lname'] !== NULL)
			$cmd->addParameter('lname', $clean['lname'] . '%', true, 'LIKE');
		if ($clean['address'] !== NULL)
			$cmd->addParameter('address', $clean['address'], true, 'LIKE');
		if ($clean['address2'] !== NULL)
			$cmd->addParameter('address2', $clean['address2'], true, 'LIKE');
		if ($clean['city'] !== NULL)
			$cmd->addParameter('city', $clean['city'], true, 'LIKE');
		if ($clean['state'] !== NULL)
			$cmd->addParameter('state', $clean['state']);
		if ($clean['country'] !== NULL)
			$cmd->addParameter('country', $clean['country']);
		if ($clean['zip'] !== NULL)
			$cmd->addParameter('zip', $clean['zip']);
		if ($clean['phone'] !== NULL)
			$cmd->addParameter('phone', '%' . $clean['phone'] . '%', true, 'LIKE');
		if ($clean['email'] !== NULL)
			$cmd->addParameter('email', $clean['email']);
		
		// Sends the query and stores the result.
		$results = $GLOBALS['con']->query($cmd->getSQL(' ORDER BY rowid DESC'));
		if (!is_object($results))
			return false;

		// Prepare an array to hold the results and become a JSON string
		$jsonArray = array();
		while($row = $results->fetch_array(MYSQL_ASSOC))
			$jsonArray[] = $row;

		// Encode and store the JSON string
		$GLOBALS['RETURN']->addData('return', json_encode($jsonArray));
		//print(json_encode($jsonArray) . PHP_EOL);
		
		// Close the query results
		$results->close();
		
		// Successful operation
		return true;
	}
}
?>