<?php
	if (!isset($clean))
	{
		$clean = array();
		
		if (isset($_POST['fname']))
			$clean[fname] = $_POST[fname];
		if (isset($_POST['lname']))
			$clean[lname] = $_POST[lname];
		if (isset($_POST['address']))
			$clean[address] = $_POST[address];
		if (isset($_POST['address2']))
			$clean[address2] = $_POST[address2];
		if (isset($_POST['state']))
			$clean[state] = $_POST[state];
		if (isset($_POST['zip']))
			$clean[zip] = $_POST[zip];
		if (isset($_POST['phone']))
			$clean[phone] = $_POST[phone];
		if (isset($_POST['email']))
			$clean[email] = $_POST[email];
	
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
		else die("USRF"); // Username DNE.
		
		if (isset($_POST[pwd])) {
			if (isproperLength($_POST[pwd])) {
				$clean['pwd'] = mysqli_real_escape_string($con, $_POST[pwd]);
			}
			else die("PWDL"); // Password improper length
		}
		else die("PWD"); // Password DNE.
		*/
	}
?>