<?php
	include '/home/ubuntu/pwd/MYSQLpwd.php';
	
	$con = new mysqli('localhost', $username, $password, $database);
	
	if ($con->connect_error) { die("SRV"); } // Server error.
?>