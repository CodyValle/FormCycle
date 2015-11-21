<?php
	/*
	File: JunkData.php
	Short: Fills the database with junk data.
	Long: Creates multiple customers, some owning multiple bikes, then creates
	work orders on those bikes.
	*/
	
	include_once 'randomStrings.php';
	include 'NubsNameGen/Generator.php';
	$generator = new StuffGenerator();
	
	include '../loginCapstone.php';

	include '../filter.php';
	include '../customer.php';
	include '../bike.php';
	include '../workOrder.php';
	
	$cust = new Customer;
	$bike = new Bike;
	$work = new WorkOrder;
	
	$entries = 10;
	for ($i = 0; $i < $entries; $i++)
	{	
		// Create a random customer
		$clean['fname'] = $generator->getAdjective();
		$clean['lname'] = $generator->getNoun();
		$clean['address'] = RandomNumericString(rand(1, 4)) . " " . $generator->getNoun() . " St.";
		$clean['address2'] = rand(0, 10) > 2 ? "" : "Apt. #" . RandomNumericString(rand(1, 3));
		$clean['city'] = $generator->getCity();
		$clean['state'] = $generator->getStateCode();
		$clean['country'] = RandomUpperAlphaString(3);
		$clean['zip'] = RandomNumericString(5);
		$clean['phone'] = RandomNumericString(10);
		$clean['email'] = $generator->getAdjective() . RandomNumericString(rand(1, 4)) . "@" . $generator->getNoun() . ".com";
		
		// Add him/her/it to the database
		if (!$cust->sendCustInfo($clean))
		{	
			// The query failed for some reason
			$i--;
			if (!isset($fails)) $fails = 0;
			$fails++;
			if ($fails >= $entries * 0.05) // 5% maximum allowed failures
				die("JNKCST");
			continue;
		}
		if (isset($fails)) $fails = 0;
		
		//print($i . ":CUSTID=" . $clean['custid'] . PHP_EOL);
		
		$clean['brand'] = $generator->getBikeBrand();
		$clean['color'] = $generator->getColor();
		$clean['model'] = $generator->getAdjective();
		$clean['notes'] = RandomAlphaString(rand(10, 30));
		
		// Add him/her/it to the database
		if (!$bike->sendBikeInfo($clean))
		{	
			// The query failed for some reason
			$i--;
			if (!isset($fails)) $fails = 0;
			$fails++;
			if ($fails >= $entries * 0.05) // 5% maximum allowed failures
				die("JNKBIK");
			continue;
		}
		if (isset($fails)) $fails = 0;
		
		
		$orders = rand(0, 10);
		for ($o = 0; $o < $orders; $o++)
		{
			$clean['open'] = (rand(0, 100) < 10 ? 'Y' : 'N');
			$clean['pre'] = RandomAlphaString(rand(10, 30));
			$clean['post'] = RandomAlphaString(rand(10, 30));
		
			if (!$work->sendWorkOrderInfo($clean))
			{
				// The query failed for some reason
				$o--;
				if (!isset($fails)) $fails = 0;
				$fails++;
				if ($fails >= $orders * 0.05) // 5% maximum allowed failures
					die("JNKWRK");
				continue;
			}
			
			$tunes = rand(1, 5);
			for ($u = 0; $u < $tunes; $u++)
			{
				$work->addTune($clean, rand(0, 10));
			}
			
			//print("  CUSTID=" . $clean['custid'] . " WORKID=" . $clean['workid'] . PHP_EOL);
		}
	}
	
	if ($con) mysqli_close($con);
?>