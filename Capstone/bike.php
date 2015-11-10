<?php
	function bikeExists(&$clean)
	{
		include 'loginCapstone.php';

		$test = mysqli_query($con, "select bikeid from BikeData where brand='" . $clean['brand'] . "' and model='" . $clean['model'] . "' and color='" . $clean['color'] . "';");
		
		$num = mysqli_num_rows($test);
		if ($num < 1)
			return false;
		
		$clean['bikeid'] = getBikeID($guid);
			
		return true;
	}

	function sendBikeInfo(&$clean)
	{
		include 'loginCapstone.php';
		
		if (bikeExists($clean))
		{
			// Insert notes data
			return insertBikeNotes($clean);
		}
		
		if (mysqli_query($con, "insert into BikeData (brand, model, color, bikeid) values ('" . $clean['brand'] . "','" . $clean['model'] . "','" . $clean['color'] . "', UNHEX(REPLACE(UUID(), '-', '')));"))
		{
			$guid = mysqli_query($con, "select bikeid from BikeData where rowid='" . $con->insert_id . "';");
			
			$clean['bikeid'] = getBikeID($guid);
			
			// Insert notes data
			return insertBikeNotes($clean);
		}

		return false;
	}
	
	function insertBikeNotes(&$clean)
	{
		include 'loginCapstone.php';
		return mysqli_query($con, "insert into BikeNoteData (bikeid, notes) values ('" . $clean['bikeid'] . "','" . $clean['notes'] . "');");
	}
	
	function getBikeID($record)
	{
		$row = mysqli_fetch_assoc($record);
			
		foreach ($row as $cname => $cvalue)
			return $cvalue;
	}
?>