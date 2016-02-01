<?php
	/*
	File: loginCapstone.php
	Short: Logs into the MySQL Database.
	Long: Creates a singleton MySQLi object for use anywhere.
	*/
	
	// Keeps the password safe from prying eyes.
	include '/home/ubuntu/pwd/MYSQLpwd.php';
	
	// Check to see if a connection has been made yet.
	if (!isset($GLOBALS['con']))
	{
		// Create singleton connection
		$GLOBALS['con'] = new mysqli('localhost', 'root', $password, 'Capstone');
		// Check connection success
		if ($GLOBALS['con']->connect_error) $GLOBALS['ERROR']->reportErrorCode("CON"); // Database connection error
		else if ($GLOBALS['DEBUG'])
			$GLOBALS['DBGMSG']->addMessage("Successfully created connection to database.");
	}
	else $GLOBALS['ERROR']->reportErrorCode("OLDCON");
?>