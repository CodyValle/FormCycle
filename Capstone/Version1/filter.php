<?php
	/*
	File: filter.php
	Short: Fills the clean array.
	Long: Creates a singleton array called 'clean' which is filled with values
	to put into the database, that are checked for proper consistency with
	expected values.
	*/
	
	include_once 'debug.php';
	
	// Check that clean does not already exist.
	if (!isset($clean))
	{	
		// Instantiate the clean array.
		$clean = array();
		
	/** Customer information **/
		// Check first name
		if (isset($_POST['fname']))
			$clean[fname] = $_POST[fname];
		else $clean['fname'] = "";
		
		// Check last name
		if (isset($_POST['lname']))
			$clean[lname] = $_POST[lname];
		else $clean['lname'] = "";
		
		// Check address line 1
		if (isset($_POST['address']))
			$clean[address] = $_POST[address];
		else $clean['address'] = "";
		
		// Check address line 2
		if (isset($_POST['address2']))
			$clean[address2] = $_POST[address2];
		else $clean['address2'] = "";
		
		// Check city
		if (isset($_POST['city']))
			$clean[city] = $_POST[city];
		else $clean['city'] = "";
		
		// Check state
		if (isset($_POST['state']))
			$clean[state] = $_POST[state];
		else $clean['state'] = "";
		
		// Check zip code
		if (isset($_POST['zip']))
			$clean[zip] = $_POST[zip];
		else $clean['zip'] = "";
		
		// Check phone number
		if (isset($_POST['phone']))
			$clean[phone] = $_POST[phone];
		else $clean['phone'] = "";
		
		// Check email
		if (isset($_POST['email']))
			$clean[email] = $_POST[email];
		else $clean['email'] = NULL;

	/** Bike Information **/
		// Check bike brand
		if (isset($_POST['brand']))
			$clean[brand] = $_POST[brand];
		else $clean['brand'] = "";
		
		// Check bike model
		if (isset($_POST['model']))
			$clean[model] = $_POST[model];
		else $clean['model'] = "";
		
		// Check bike color
		if (isset($_POST['color']))
			$clean[color] = $_POST[color];
		else $clean['color'] = "";
		
		// Check bike tag number
		if (isset($_POST['tagNum']))
			$clean[tagNum] = $_POST[tagNum];
		else $clean['tagNum'] = "";
		
		// Check bike notes
		if (isset($_POST['notes']))
			$clean[notes] = $_POST[notes];
		else $clean['notes'] = "";
		
	/** Work Order Information **/
		// Check pre work order notes
		if (isset($_POST['pre']))
			$clean[pre] = $_POST[pre];
		else $clean['pre'] = "";

		// Check post work order notes
		if (isset($_POST['post']))
			$clean[post] = $_POST[post];
		else $clean['post'] = "";

		// Print the clean array and all associated values if debugging is turned on.
		if ($DEBUG)
		{
			print("***DEBUG SECTION***" . PHP_EOL);
			
			foreach ($clean as $key => $val)
				print($key . ": " . $val . PHP_EOL);
				
			print("***END DEBUG SECTION***" . PHP_EOL);
		}
	
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