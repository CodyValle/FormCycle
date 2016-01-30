<?php
	/*
	File: filter.php
	Short: Fills the clean array.
	Long: Creates a singleton array called 'clean' which is filled with values
	to put into the database, that are checked for proper consistency with
	expected values.
	*/
	
	if ($GLOBALS['DEBUG']) print("Running filter." . PHP_EOL);
	
	// Check that clean does not already exist.
	if (!isset($clean))
	{	
		// Instantiate the clean array.
		$clean = array();
		
	/** Customer information **/
		// Check first name
		if (isset($_POST['fname']) && trim($_POST['fname']) !== "")
		{
			$clean['fname'] = trim($_POST['fname']);
		}
		else $clean['fname'] = NULL;
		
		// Check last name
		if (isset($_POST['lname']) && trim($_POST['lname']) !== "")
		{
			$clean['lname'] = trim($_POST['lname']);
		}
		else $clean['lname'] = NULL;
		
		// Check address line 1
		if (isset($_POST['address']) && trim($_POST['address']) !== "")
		{
			$clean['address'] = trim($_POST['address']);
		}
		else $clean['address'] = NULL;
		
		// Check address line 2
		if (isset($_POST['address2']) && trim($_POST['address2']) !== "")
		{
			$clean['address2'] = trim($_POST['address2']);
		}
		else $clean['address2'] = NULL;
		
		// Check city
		if (isset($_POST['city']) && trim($_POST['city']) !== "")
		{
			$clean['city'] = trim($_POST['city']);
		}
		else $clean['city'] = NULL;
		
		// Check state
		if (isset($_POST['state']) && trim($_POST['state']) !== "")
		{
			$clean['state'] = trim($_POST['state']);
		}
		else $clean['state'] = NULL;
		
		// Check zip code
		if (isset($_POST['zip']) && trim($_POST['zip']) !== "")
		{
			$clean['zip'] = trim($_POST['zip']);
		}
		else $clean['zip'] = NULL;
		
		// Check country code
		if (isset($_POST['country']) && trim($_POST['country']) !== "")
		{
			$clean['country'] = trim($_POST['country']);
		}
		else $clean['country'] = NULL;
		
		// Check phone number
		if (isset($_POST['phone']) && trim($_POST['phone']) !== "")
		{
			$clean['phone'] = trim($_POST['phone']);
		}
		else $clean['phone'] = NULL;
		
		// Check email
		if (isset($_POST['email']) && trim($_POST['email']) !== "")
		{
			$clean['email'] = trim($_POST['email']);
		}
		else $clean['email'] = NULL;

	/** Bike Information **/
		// Check bike brand
		if (isset($_POST['brand']) && trim($_POST['brand']) !== "")
		{
			$clean['brand'] = trim($_POST['brand']);
		}
		else $clean['brand'] = NULL;
		
		// Check bike model
		if (isset($_POST['model']) && trim($_POST['model']) !== "")
		{
			$clean['model'] = trim($_POST['model']);
		}
		else $clean['model'] = NULL;
		
		// Check bike color
		if (isset($_POST['color']) && trim($_POST['color']) !== "")
		{
			$clean['color'] = trim($_POST['color']);
		}
		else $clean['color'] = NULL;
		
		// Check bike tag number
		if (isset($_POST['tagNum']) && trim($_POST['tagNum']) !== "")
		{
			$clean['tagNum'] = trim($_POST['tagNum']);
		}
		else $clean['tagNum'] = NULL;
		
		// Check bike notes
		if (isset($_POST['notes']) && trim($_POST['notes']) !== "")
		{
			$clean['notes'] = trim($_POST['notes']);
		}
		else $clean['notes'] = NULL;
		
	/** Work Order Information **/
		// Check whether this work order is open
		if (isset($_POST['open']) && trim($_POST['open']) !== "")
		{
			$clean['open'] = trim($_POST['open']);
		}
		else $clean['open'] = NULL;
		
		// Check when this work order is made (used for searching)
		if (isset($_POST['date']) && trim($_POST['date']) !== "")
		{
			$clean['date'] = trim($_POST['date']);
		}
		else $clean['date'] = NULL;
		
		// Check pre work order notes
		if (isset($_POST['pre']) && trim($_POST['pre']) !== "")
		{
			$clean['pre'] = trim($_POST['pre']);
		}
		else $clean['pre'] = NULL;

		// Check post work order notes
		if (isset($_POST['post']) && trim($_POST['post']) !== "")
		{
			$clean['post'] = trim($_POST['post']);
		}
		else $clean['post'] = NULL;
		
	/** Log In Information **/
		// Check for id number
		if (isset($_POST['logid']) && trim($_POST['logid']) !== "")
		{
			$clean['logid'] = trim($_POST['logid']);
		}
		else $clean['logid'] = NULL;

		// Check for pin
		if (isset($_POST['pwd']) && trim($_POST['pwd']) !== "")
		{
			$clean['pwd'] = trim($_POST['pwd']);
		}
		else $clean['pwd'] = NULL;
	
	// Notes for reference
		/*
		if (isset($_POST[username])) {
			if (isproperLength($_POST[username])) {
				if (isValidUsername($_POST[username])) {
					$clean['username'] = mysqli_real_escape_string($con, $_POST[username]);
				}
				else die("USRI"); // Username invalid
			}
			else die("USRL"); // Username improper length
		}
		else die("USRF"); // Username .
		
		if (isset($_POST[pwd])) {
			if (isproperLength($_POST[pwd])) {
				$clean['pwd'] = mysqli_real_escape_string($con, $_POST[pwd]);
			}
			else die("PWDL"); // Password improper length
		}
		else die("PWD"); // Password .
		*/
	}
?>