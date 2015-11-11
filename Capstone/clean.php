<?php
	include 'loginCapstone.php';
	
	$statement = "delete from CustData;";
	$statement .= "delete from BikeData;";
	$statement .= "delete from BikeNoteData;";
	$statement .= "delete from BikeIMGData;";
	$statement .= "delete from WorkOrderData;";
	$statement .= "delete from WorkOrderNotes;";
	$statement .= "delete from TuneData;";
	
	if (mysqli_multi_query($con, $statement))
		print("SUC" . PHP_EOL);
	else print("ERR" . PHP_EOL);
	
	mysqli_close($con);
?>