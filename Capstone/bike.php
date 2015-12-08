<?php
	/*
	File: bike.php
	Short: Deals with all bike data interaction.
	Long: Contains functions to check whether the bike already exists in the
	database and adds it to the database.
	*/
	
	include_once 'MySQLCommand.php';
	
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
		// Creates a new MYSQLSelectCommand to select data from the 'BikeData' table.
		$cmd = new MYSQLSelectCommand('BikeData');
		$cmd->addColumn("HEX(bikeid) as bikeid");
		if ($clean['brand'] !== NULL)
			$cmd->addParameter('brand', $clean['brand']);
		if ($clean['model'] !== NULL)
			$cmd->addParameter('model', $clean['model']);
		if ($clean['color'] !== NULL)
			$cmd->addParameter('color', $clean['color']);
		
		// Sends the query and stores the result.
		$test = $GLOBALS['con']->query($cmd->getSQL());
		//print($cmd->getSQL() . PHP_EOL);
		if (!is_object($test))
		{
			$GLOBALS['ERROR']->reportErrorCode("BIKSL");
			$GLOBALS['ERROR']->reportError("BIKSL" . $clean['model'] . $clean['color'], $cmd->getSQL());	
			return false;
		}
		
		// Checks whether a record was found.
		if ($test->num_rows < 1)
			return false;
		
		$clean['bikeid'] = $test->fetch_assoc()['bikeid'];
			
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
		if ($this->bikeExists($clean))
		{
			// The bike exists, so insert notes data
			return $this->insertBikeNotes($clean);
		}
		
		// Creates a new MYSQLInsertCommand to insert data into the 'BikeData' table.
		$cmd = new MYSQLInsertCommand('BikeData');
		$cmd->addID('bikeid');
		if ($clean['brand'] !== NULL)
			$cmd->addParameter('brand', $clean['brand']);
		if ($clean['model'] !== NULL)
			$cmd->addParameter('model', $clean['model']);
		if ($clean['color'] !== NULL)
			$cmd->addParameter('color', $clean['color']);
		if ($clean['custid'] !== NULL)
			$cmd->addParameter('custid', "UNHEX('" . $clean['custid'] . "')", false);
		
		// Send the query
		if ($GLOBALS['con']->query($cmd->getSQL()))
		{
			// If the insert was successful,
			// create a new MYSQLSelectCommand to retrieve the bike's handle.
			$sel = new MYSQLSelectCommand('BikeData');
			$sel->addColumn("HEX(bikeid) AS bikeid");
			$sel->addParameter('rowid', $GLOBALS['con']->insert_id);
			
			$guid = $GLOBALS['con']->query($sel->getSQL());
			
			$clean['bikeid'] = $guid->fetch_assoc()['bikeid'];
			
			// Insert notes data
			return $this->insertBikeNotes($clean);
		}

		$GLOBALS['ERROR']->reportErrorCode("BIKIN");
		$GLOBALS['ERROR']->reportError("BIKIN" . $clean['model'] . $clean['color'], $cmd->getSQL());
		return false;
	}
	
	/*
	Function: insertBikeNotes
	Param clean: The clean array with all of the variables to be put into the database.
	Descrip: Inserts notes about the bike into the database.
	*/
	function insertBikeNotes(&$clean)
	{
		// Creates a new MYSQLInsertCommand to insert data into the 'BikeData' table.
		$cmd = new MYSQLInsertCommand('BikeNoteData');
		if ($clean['bikeid'] !== NULL)
			$cmd->addParameter("bikeid", "UNHEX('" . $clean['bikeid'] . "')", false);
		if ($clean['notes'] !== NULL)
			$cmd->addParameter('notes', $clean['notes']);
		
		if (!$GLOBALS['con']->query($cmd->getSQL()))
		{
			$GLOBALS['ERROR']->reportErrorCode("BIKNOT");
			$GLOBALS['ERROR']->reportError("BIKNOT" . $clean['model'] . $clean['color'], $cmd->getSQL());
			return false;
		}
		
		return true;
	}
}
?>