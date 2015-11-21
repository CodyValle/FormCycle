<?php
	/*
	File: customer.php
	Short: Deals with all customer data interaction.
	Long: Contains functions to check whether the customer already exists in the
	database and adds them to the database.
	*/
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
		// Allows connection to the database.
		include 'loginCapstone.php';
 
		// Sends the query and stores the result.
		$test = mysqli_query($con, "select custid from CustData
									where fname='" . $clean['fname'] . "'
									and lname='" . $clean['lname'] . "'
									and address='" . $clean['address'] . "'
									and address2='" . $clean['address2'] . "'
									and city='" . $clean['city'] . "'
									and state='" . $clean['state'] . "'
									and country='" . $clean['country'] . "'
									and zip='" . $clean['zip'] . "'
									and phone='" . $clean['phone'] . "'
									and email='" . $clean['email'] . "';");
		
		// Checks whether a record was found.
		$num = mysqli_num_rows($test);
		if ($num < 1)
			return false;

		// Gets the customer ID from the returned record and stores it in the clean array.
		$clean['custid'] = getCustID($test);

		// Success.
		return true;
	}

	/*
	Function: sendCustInfo
	Param clean:
	Descrip:
	*/
	function sendCustInfo(&$clean)
	{
		include 'loginCapstone.php';
		
		if ($this->custExists($clean))
			return true;
		
		if (mysqli_query($con, "insert into CustData 
								(fname, lname, address, address2, city,
								 state, country, zip, phone, email, custid)
								values 
								('" . $clean['fname'] . "',
								 '" . $clean['lname'] . "',
								 '" . $clean['address'] . "',
								 '" . $clean['address2'] . "',
								 '" . $clean['city'] . "',
								 '" . $clean['state'] . "',
								 '" . $clean['country'] . "',
								 '" . $clean['zip'] . "',
								 '" . $clean['phone'] . "',
								 '" . $clean['email'] . "',
								 UNHEX(REPLACE(UUID(), '-', '')));"))
		{
			$guid = mysqli_query($con, "select custid from CustData where
											rowid='" . $con->insert_id . "';");
			
			$clean['custid'] = $this->getCustID($guid);
			
			return true;
		}

		print(mysqli_error($con));
		return false;
	}
	
	/*
	Function: getCustID
	Param record: 
	Descrip:
	*/
	function getCustID($record)
	{
		$row = mysqli_fetch_assoc($record);
			
		foreach ($row as $cname => $cvalue)
			return $cvalue;
	}
}
?>