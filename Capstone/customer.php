<?php
	function checkCustExists(&$clean)
	{
		$test = mysqli_query($con, "select country from CustData where fname='" . $clean[fname] . "' and lname='" . $clean[lname] . "' and address='" . $clean[address] . "' and city='" . $clean[city] . "' and phone='" . $clean[phone] . "' and email='" . $clean[email] . "';");
		$num = mysqli_num_rows($test);
		if ($num < 1)
			return false;
		else if ($num > 1)
		{
			print("Multiple customers..."); // This should not happen
		}
		
		return true;
	}

	function sendCustInfo(&$clean) {
		include 'loginCapstone.php';
		
		print("insert into CustData (fname, lname, address, address2, city, state, country, zip, phone, email, custid) values ('" . $clean[fname] . "','" . $clean[lname] . "','" . $clean[address] . "','" . $clean[address2] . "','" . $clean[city] . "','" . $clean[state] . "','" . $clean[country] . "','" . $clean[zip] . "', '" . $clean[phone] . "','" . $clean[email] . "', UNHEX(REPLACE(UUID(), '-', '')));");
		if (mysqli_query($con, "insert into CustData (fname, lname, address, address2, city, state, country, zip, phone, email, custid) values ('" . $clean[fname] . "','" . $clean[lname] . "','" . $clean[address] . "','" . $clean[address2] . "','" . $clean[city] . "','" . $clean[state] . "','" . $clean[country] . "','" . $clean[zip] . "', '" . $clean[phone] . "','" . $clean[email] . "', UNHEX(REPLACE(UUID(), '-', '')));"))
		{
			$string = mysqli_use_result($con);
			print("String: " . $string);
			//getCustID($clean);
			return true;
		}

		return false;
	}
	
	function getCustID(&$clean)
	{
		include 'loginCapstone.php';
		
		// Get the customer's handle
		$guid = mysqli_query($con, "select HEX(custid) from CustData where fname='" . $clean[fname] . "' and lname='" . $clean[lname] . "' and address='" . $clean[address] . "' and city='" . $clean[city] . "' and phone='" . $clean[phone] . "' and email='" . $clean[email] . "';");
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