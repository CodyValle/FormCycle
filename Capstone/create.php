<?php
	function create() {
		include 'loginCapstone.php';
		include 'filter.php';
		
		$usrtest = mysqli_query($con, "select username from login where username='" . $clean['username'] . "';");
		if (mysqli_num_rows($usrtest) > 0) { die("USRE"); } // Username already exists.
		
		mysqli_query($con, "insert into login values ('" . $clean['username'] . "', '" . $clean['pwd'] . "', UNHEX(REPLACE(UUID(), '-', '')));");

		$guid = mysqli_query($con, "select HEX(guid) from login where username='" . $clean['username'] . "' and pwd='" . $clean['pwd'] . "';");
		
		$row = mysqli_fetch_assoc($guid);
		foreach($row as $cname => $cvalue)
		{ print "$cvalue"; } // All good! Carry on.
		
		mysqli_close();
	}
?>