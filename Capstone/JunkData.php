<?php
	// Good comments.
	
	include_once 'randomStrings.php';
	include 'loginCapstone.php';

	include 'filter.php';
	include 'customer.php';
	include 'bike.php';
	include 'workOrder.php';
	
	$entries = 1;
	for ($i = 0; $i < $entries; $i++)
	{
		if (!($i === 4 || $i === 6))
		{
			// Create a random customer
			$clean['fname'] = RandomAlphaString(rand(3,10));
			$clean['lname'] = RandomAlphaString(rand(3,10));
			$clean['address'] = RandomNumericString(rand(1, 4)) . " " . RandomAlphaString(rand(3, 7)) . " St.";
			$clean['address2'] = "Apt. #" . RandomNumericString(rand(1, 3));
			$clean['city'] = RandomAlphaString(rand(3,12));
			$clean['state'] = RandomAlphaString(2);
			$clean['zip'] = RandomNumericString(5);
			$clean['country'] = RandomAlphaString(2);
			$clean['phone'] = RandomNumericString(10);
			$clean['email'] = RandomString(rand(3,5)) . "@" . RandomAlphaString(rand(2, 6)) . ".com";
		}
		/*
		// Add him/her/it to the database
		if (!sendCustInfo($clean))
		{	
			// The query failed for some reason
			$i--;
			if (!isset($fails)) $fails = 0;
			$fails++;
			if ($fails >= $entries * 0.05) // 5% maximum allowed failures
				die("JNK");
			continue;
		}
		if (isset($fails)) $fails = 0;
		
		print($i . ":CUSTID=" . $clean['custid'] . PHP_EOL);
		*/
		$clean['brand'] = RandomString(5);
		$clean['model'] = RandomString(7);
		$clean['color'] = RandomString(4);
		$clean['bnotes'] = RandomString(rand(100, 300));
		
		
		if (!sendCustInfo($clean))
			die("CST");
		if (!sendBikeInfo($clean))
			die("BIK");
		
		/*
		$orders = rand(0, 10);
		for ($o = 0; $o < $orders; $o++)
		{
			$clean['open'] = (rand(0, 100) < 10 ? 'Y' : 'N');
			$clean['tune'] = RandomNumericString(1);
		
			$clean['pre'] = RandomString(rand(100, 300));
			$clean['post'] = RandomString(rand(100, 300));
		
			if (!sendWorkOrderInfo($clean))
			{
				// The query failed for some reason
				$o--;
				if (!isset($fails)) $fails = 0;
				$fails++;
				if ($fails >= $orders * 0.05) // 5% maximum allowed failures
					die("JNK2");
				continue;
			}
			
			print("  CUSTID=" . $clean['custid'] . " WORKID=" . $clean['workid'] . PHP_EOL);
		}
		*/
	}
	
	if ($con) mysqli_close($con);
?>