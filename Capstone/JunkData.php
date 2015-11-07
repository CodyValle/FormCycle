<?php
	include_once 'randomStrings.php';
	include 'loginCapstone.php';

	include 'filter.php';
	include 'customer.php';
	
	$entries = 10;
	for ($i = 0; $i < $entries; $i++)
	{
		// Create a random customer
		$clean[fname] = RandomString(rand(3,10));
		$clean[lname] = RandomString(rand(3,10));
		$clean[address] = RandomNumericString(rand(1, 4)) . " " . RandomString(rand(3, 7)) . " St.";
		$clean[address2] = "Apt. #" . RandomNumericString(rand(1, 3));
		$clean[city] = RandomString(rand(3,12));
		$clean[state] = RandomString(2);
		$clean[zip] = RandomNumericString(5);
		$clean[country] = RandomString(2);
		$clean[phone] = RandomNumericString(10);
		$clean[email] = RandomString(rand(3,5)) . "@" . RandomAlphaString(rand(2, 6)) . "." . RandomAlphaString(3);
		
		// Add him/her/it to the database
		if (!sendCustInfo($clean))
		{	
			// The query failed for some reason
			$i--;
			if (!$fails) $fails = 0;
			$fails++;
			if ($fails >= $entries * 0.05) // 5% maximum allowed failures
				die("JNK");
			continue;
		}
		else
		{
			die("There was an error.");
		}
		
		print($i . ": " . $clean[custid] . "</br>");
		
		/*$clean[open] = (rand(0, 100) < 10 ? "Y" : "N";
		$clean[tune] = RandomNumericString(1);
		
		$clean[pre] = RandomString(rand(100, 300));
		$clean[post] = RandomString(rand(100, 300));*/
	}
	
	if ($con) mysqli_close();
?>