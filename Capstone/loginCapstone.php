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
		// Check conection success
		if ($GLOBALS['con']->connect_error) $GLOBALS['ERROR']->reportErrorCode("CON"); // Database connection error
		else if ($GLOBALS['DEBUG'])
			print("Successfully created connection to database." . PHP_EOL);
	}
	else $GLOBALS['ERROR']->reportErrorCode("OLDCON");
?>