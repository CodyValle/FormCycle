<?php
	/*
	File: JunkData.php
	Short: Fills the database with junk data.
	Long: Creates multiple customers, some owning multiple bikes, then creates
	work orders on those bikes.
	*/
	
	
	include_once 'error.php';
	include_once 'debug.php';
	
	include_once 'randomStrings.php';
	include 'NubsNameGen/Generator.php';
	$generator = new StuffGenerator();
	
	include_once 'loginCapstone.php';

	include_once 'filter.php';
	include 'customer.php';
	include 'bike.php';
	include 'workOrder.php';
	
	$cust = new Customer;
	$bike = new Bike;
	$work = new WorkOrder;
	
	$entries = isset($_POST['entries']) ? $_POST['entries'] : 3;
	for ($i = 0; $i < $entries; $i++)
	{	
		// Create a random customer
		$clean['fname'] = $generator->getAdjective();
		$clean['lname'] = $generator->getNoun();
		$clean['address'] = RandomNumericString(rand(1, 4)) . " " . $generator->getNoun() . " St.";
		$clean['address2'] = rand(0, 100) > 18 ? NULL : "Apt. #" . RandomNumericString(rand(1, 3));
		$clean['city'] = $generator->getCity();
		$clean['state'] = $generator->getStateCode();
		$clean['country'] = rand(0, 100) > 5 ? NULL : RandomUpperAlphaString(3);
		$clean['zip'] = RandomNumericString(5);
		$clean['phone'] = RandomNumericString(10);
		// Less than a 0.00000000000000034% chance of being a duplicate.
		$clean['email'] = rand(0, 100) < 15 ? NULL : $generator->getAdjective() . RandomNumericString(rand(1, 4)) . $generator->getAdjective() ."@" . $generator->getNoun() . RandomNumericString(rand(1, 4)) . ".com";
		
		// Add him/her/it to the database
		if (!$cust->sendCustInfo($clean))
		{	
			// The query failed for some reason
			$i--;
			if (!isset($fails)) $fails = 0;
			$fails++;
			if ($fails >= $entries * 0.05) // 5% maximum allowed failures
			{
				$GLOBALS['ERROR']->reportErrorCode("JNKCST");
				break;
			}
			continue;
		}
		if (isset($fails)) $fails = 0;

		// Sometimes a customer has more than one bike.
		$bikes = rand(1, 100) > 3 ? 1 : 2;
		for ($b = 0; $b < $bikes; $b++)
		{
			$clean['brand'] = $generator->getBikeBrand();
			$clean['color'] = $generator->getColor() . "-ish " . $generator->getColor();
			$clean['tagNum'] = RandomNumericString(4);
			$clean['model'] = $generator->getAdjective() . $generator->getInterestingNonsense();
			$clean['notes'] = "";
			for ($c = 0; $c < rand(5, 10); $c++)
				$clean['notes'] .= $generator->getInterestingNonsense() . " ";
			
			// Add him/her/it to the database
			if (!$bike->sendBikeInfo($clean))
			{	
				// The query failed for some reason
				$i--;
				if (!isset($fails)) $fails = 0;
				$fails++;
				if ($fails >= $entries * 0.05) // 5% maximum allowed failures
				{
					$GLOBALS['ERROR']->reportErrorCode("JNKBIK");
					break;
				}
				continue;
			}
			if (isset($fails)) $fails = 0;
		}
		
		$orders = rand(0, 10);
		for ($o = 0; $o < $orders; $o++)
		{
			$clean['open'] = (rand(0, 100) < 3 ? 'Y' : 'N');
			$clean['tagid'] = RandomNumericString(2);
			
			$clean['pre'] = "";
			for ($c = 0; $c < rand(5, 10); $c++)
				$clean['pre'] .= $generator->getInterestingNonsense() . " ";
			
			$clean['post'] = "";
			for ($c = 0; $c < rand(5, 10); $c++)
				$clean['post'] .= $generator->getInterestingNonsense() . " ";
		
			if (!$work->sendWorkOrderInfo($clean))
			{
				// The query failed for some reason
				$o--;
				if (!isset($fails)) $fails = 0;
				$fails++;
				if ($fails >= $orders * 0.05) // 5% maximum allowed failures
				{
					$GLOBALS['ERROR']->reportErrorCode("JNKWRK");
					break;
				}
				continue;
			}
			
			// Create a list of unique integers (Tune IDs)
			$n = 0;
			$tunes = array();
			$numTunes = rand(1, 6);
			while (count($tunes) < $numTunes)
			{
				if (rand(0, 100) > 50)
					$tunes[] = $n;
				$n++;
			}
			// Attach those integers (Tune IDs) to the work order
			foreach ($tunes as $u)
				$work->addTune($clean['workid'], $u);
		}
	}
?>