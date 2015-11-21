<?php
	/*
	File: loginCapstone.php
	Short: Logs into the MySQL Database.
	Long: Creates a singleton MySQLi object for use anywhere.
	*/
	
	// Keeps the password safe from prying eyes.
	include '/home/ubuntu/pwd/MYSQLpwd.php';
	
	// Check to see if a connection has been made yet.
	if (!isset($con))
	{
		// Create singleton connection
		$con = new mysqli('localhost', $username, $password, $database);
		// Check conection success
		if ($con->connect_error) { die("CON"); } // Database connection error
	}
	else die("OLDCON");
?>