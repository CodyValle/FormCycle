<?php
	/*
	File: filter.php
	Short: Fills the clean array.
	Long: Creates a singleton array called 'clean' which is filled with values
	to put into the database, that are checked for proper consistency with
	expected values.
	*/
	
	if ($GLOBALS['DEBUG']) $GLOBALS['DBGMSG']->addMessage("Running filter.");
	
	// Check that clean does not already exist.
	if (!isset($clean))
	{	
		// Instantiate the clean array.
		$clean = array();
		
	/** Customer information **/
		// Check customer ID
		if (isset($_POST['custid']) && trim($_POST['custid']) !== "")
		{
			$clean['custid'] = $GLOBALS['con']->real_escape_string(trim($_POST['custid']));
		}
		else $clean['custid'] = NULL;
		
		// Check first name
		if (isset($_POST['fname']) && trim($_POST['fname']) !== "")
		{
			$clean['fname'] = $GLOBALS['con']->real_escape_string(trim($_POST['fname']));
		}
		else $clean['fname'] = NULL;
		
		// Check last name
		if (isset($_POST['lname']) && trim($_POST['lname']) !== "")
		{
			$clean['lname'] = $GLOBALS['con']->real_escape_string(trim($_POST['lname']));
		}
		else $clean['lname'] = NULL;
		
		// Check address line 1
		if (isset($_POST['address']) && trim($_POST['address']) !== "")
		{
			$clean['address'] = $GLOBALS['con']->real_escape_string(trim($_POST['address']));
		}
		else $clean['address'] = NULL;
		
		// Check address line 2
		if (isset($_POST['address2']) && trim($_POST['address2']) !== "")
		{
			$clean['address2'] = $GLOBALS['con']->real_escape_string(trim($_POST['address2']));
		}
		else $clean['address2'] = NULL;
		
		// Check city
		if (isset($_POST['city']) && trim($_POST['city']) !== "")
		{
			$clean['city'] = $GLOBALS['con']->real_escape_string(trim($_POST['city']));
		}
		else $clean['city'] = NULL;
		
		// Check state
		if (isset($_POST['state']) && trim($_POST['state']) !== "")
		{
			$clean['state'] = $GLOBALS['con']->real_escape_string(trim($_POST['state']));
		}
		else $clean['state'] = NULL;
		
		// Check zip code
		if (isset($_POST['zip']) && trim($_POST['zip']) !== "")
		{
			$clean['zip'] = $GLOBALS['con']->real_escape_string(trim($_POST['zip']));
		}
		else $clean['zip'] = NULL;
		
		// Check country code
		if (isset($_POST['country']) && trim($_POST['country']) !== "")
		{
			$clean['country'] = $GLOBALS['con']->real_escape_string(trim($_POST['country']));
		}
		else $clean['country'] = NULL;
		
		// Check phone number
		if (isset($_POST['phone']) && trim($_POST['phone']) !== "")
		{
			$clean['phone'] = $GLOBALS['con']->real_escape_string(trim($_POST['phone']));
		}
		else $clean['phone'] = NULL;
		
		// Check email
		if (isset($_POST['email']) && trim($_POST['email']) !== "")
		{
			$clean['email'] = $GLOBALS['con']->real_escape_string(trim($_POST['email']));
		}
		else $clean['email'] = NULL;

	/** Bike Information **/
		// Check bike brand
		if (isset($_POST['brand']) && trim($_POST['brand']) !== "")
		{
			$clean['brand'] = $GLOBALS['con']->real_escape_string(trim($_POST['brand']));
		}
		else $clean['brand'] = NULL;
		
		// Check bike model
		if (isset($_POST['model']) && trim($_POST['model']) !== "")
		{
			$clean['model'] = $GLOBALS['con']->real_escape_string(trim($_POST['model']));
		}
		else $clean['model'] = NULL;
		
		// Check bike color
		if (isset($_POST['color']) && trim($_POST['color']) !== "")
		{
			$clean['color'] = $GLOBALS['con']->real_escape_string(trim($_POST['color']));
		}
		else $clean['color'] = NULL;
		
		// Check bike tag number
		if (isset($_POST['tagNum']) && trim($_POST['tagNum']) !== "")
		{
			$clean['tagNum'] = $GLOBALS['con']->real_escape_string(trim($_POST['tagNum']));
		}
		else $clean['tagNum'] = NULL;
		
		// Check bike notes
		if (isset($_POST['notes']) && trim($_POST['notes']) !== "")
		{
			$clean['notes'] = $GLOBALS['con']->real_escape_string(trim($_POST['notes']));
		}
		else $clean['notes'] = NULL;
		
	/** Work Order Information **/
		// Check the specific work order
		if (isset($_POST['workid']) && trim($_POST['workid']) !== "")
		{
			$clean['workid'] = $GLOBALS['con']->real_escape_string(trim($_POST['workid']));
		}
		else $clean['workid'] = NULL;
		
		// Check the username
		if (isset($_POST['userID']) && trim($_POST['userID']) !== "")
		{
			$clean['userID'] = $GLOBALS['con']->real_escape_string(trim($_POST['userID']));
		}
		else $clean['userID'] = NULL;
		
		// Check whether this work order is open
		if (isset($_POST['open']) && trim($_POST['open']) !== "")
		{
			$clean['open'] = $GLOBALS['con']->real_escape_string(trim($_POST['open']));
		}
		else $clean['open'] = NULL;
		
		// Check what type of tune this is
		if (isset($_POST['tune']) && trim($_POST['tune']) !== "")
		{
			$clean['tune'] = $GLOBALS['con']->real_escape_string(trim($_POST['tune']));
		}
		else $clean['tune'] = NULL;
		
		// Check when this work order is made (used for searching)
		if (isset($_POST['date']) && trim($_POST['date']) !== "")
		{
			$clean['date'] = $GLOBALS['con']->real_escape_string(trim($_POST['date']));
		}
		else $clean['date'] = NULL;
		
		// Check pre work order notes
		if (isset($_POST['pre']) && trim($_POST['pre']) !== "")
		{
			$clean['pre'] = $GLOBALS['con']->real_escape_string(trim($_POST['pre']));
		}
		else $clean['pre'] = NULL;

		// Check post work order notes
		if (isset($_POST['post']) && trim($_POST['post']) !== "")
		{
			$clean['post'] = $GLOBALS['con']->real_escape_string(trim($_POST['post']));
		}
		else $clean['post'] = NULL;
		
	/** Log In Information **/
		// Check for id number
		if (isset($_POST['logid']) && trim($_POST['logid']) !== "")
		{
			$clean['logid'] = $GLOBALS['con']->real_escape_string(trim($_POST['logid']));
		}
		else $clean['logid'] = NULL;

		// Check for pin
		if (isset($_POST['pwd']) && trim($_POST['pwd']) !== "")
		{
			$clean['pwd'] = $GLOBALS['con']->real_escape_string(trim($_POST['pwd']));
		}
		else $clean['pwd'] = NULL;
	}
?>