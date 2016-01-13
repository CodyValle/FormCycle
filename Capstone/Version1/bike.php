<?php
	/*
	File: bike.php
	Short: Deals with all bike data interaction.
	Long: Contains functions to check whether the bike already exists in the
	database and adds it to the database.
	*/
	
class Bike
{
	/*
	Function: bikeExists
	Param clean: Reference to the array of URL variables that have been checked for
	valid values.
	Descrip: Uses the variable values passed in to find an identical record. The
	function returns true if a record is found.
	*/
	function bikeExists(&$clean)
	{
		include 'loginCapstone.php';

		$test = mysqli_query($con, "select bikeid from BikeData where
									brand='" . $clean['brand'] . "'
									and model='" . $clean['model'] . "'
									and color='" . $clean['color'] . "';");
		
		$num = mysqli_num_rows($test);
		if ($num < 1)
			return false;
		
		$clean['bikeid'] = $this->getBikeID($guid);
			
		return true;
	}

	/*
	Function: sendBikeInfo
	Param clean: A clean array with all the variables for the data about the bike.
	Descrip: Sends the bike information into the database, as well as adds the bikeid
	to the clean array.
	*/
	function sendBikeInfo(&$clean)
	{
		include 'loginCapstone.php';
		
		if ($this->bikeExists($clean))
		{
			// Insert notes data
			return $this->insertBikeNotes($clean);
		}
		
		if (mysqli_query($con, "insert into BikeData (brand, model, color, custid, bikeid)
								values
								('" . $clean['brand'] . "',
								 '" . $clean['model'] . "',
								 '" . $clean['color'] . "',
								 '" . $clean['custid'] . "',
								 UNHEX(REPLACE(UUID(), '-', '')));"))
		{
			$guid = mysqli_query($con, "select bikeid from BikeData where
										rowid='" . $con->insert_id . "';");
			
			$clean['bikeid'] = $this->getBikeID($guid);
			
			// Insert notes data
			return $this->insertBikeNotes($clean);
		}

		print(mysqli_error($con));
		return false;
	}
	
	/*
	Function: insertBikeNotes
	Param clean: The clean arraty with all of the variables to be put into the database.
	Descrip: Inserts notes about the bike into the database.
	*/
	function insertBikeNotes(&$clean)
	{
		include 'loginCapstone.php';
		return mysqli_query($con, "insert into BikeNoteData (bikeid, notes)
									values
									('" . $clean['bikeid'] . "',
									 '" . $clean['notes'] . "');")
				or die(mysqli_error($con));;
	}
	
	/*
	Function: getBikeID
	Param record: A result from a select query to the database.
	Descrip: Returns the first bike ID from the result. Does not check to see if there
	is more than one record.
	*/
	function getBikeID($record)
	{
		$row = mysqli_fetch_assoc($record);
			
		foreach ($row as $cname => $cvalue)
			return $cvalue;
	}
}
?>