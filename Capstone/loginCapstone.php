<?php
	$username = "root";
	$password = "chronicc8";
	$database = "Capstone";
	
	if (!$con) $con = new mysqli(localhost, $username, $password, $database);
	
	if ($con->connect_error) { die("CON"); } // Connect error.
?>