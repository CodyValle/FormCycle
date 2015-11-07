<?php
<<<<<<< HEAD
	function get() {
		include '/home/ubuntu/loginTest/testLogin.php';
		include '/home/ubuntu/loginTest/filter.php';

		$usrtest = mysqli_query($con, "select username from login where username='" . $clean['username'] . "';");
		if (!(mysqli_num_rows($usrtest) == 1)) { die("USR"); } // Username does not exist.

		$guid = mysqli_query($con, "select HEX(guid) from login where username='" . $clean['username'] . "' and pwd='" . $clean['pwd'] . "';");
		if (!(mysqli_num_rows($guid) == 1)) { die("PWDF"); } // Password does not match.
		
		$row = mysqli_fetch_assoc($guid);
		foreach($row as $cname => $cvalue)
		{ print "$cvalue"; } // All good! Carry on.
		
		mysqli_close();
	}
=======
	include '/home/ubuntu/pwd/MYSQLpwd.php';
	
	$con = new mysqli('localhost', $username, $password, $database);
	
	if ($con->connect_error) { die("SRV"); } // Server error.
>>>>>>> 0b28e4fc0a17aefc275313e08e621359aab1f3bf
?>