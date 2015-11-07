<?php
	if (!$clean)
	{
		$clean = array();
		
		if ($_POST[fname])
			clean[fname] = $_POST[fname];
		if ($_POST[lname])
			clean[lname] = $_POST[lname];
		if ($_POST[address])
			clean[address] = $_POST[address];
		if ($_POST[address2])
			clean[address2] = $_POST[address2];
		if ($_POST[state])
			clean[state] = $_POST[state];
		if ($_POST[zip])
			clean[zip] = $_POST[zip];
		if ($_POST[phone])
			clean[phone] = $_POST[phone];
		if ($_POST[email])
			clean[email] = $_POST[email];
	
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