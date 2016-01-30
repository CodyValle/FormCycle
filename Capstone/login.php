<?php

include_once 'MySQLCommand.php';

class Login
{
	public static function run(&$clean) //comment test
	{
		// Create the command
		$sel = new MySQLSelectCommand('LogInData');
		$sel->addColumn('username');
		$sel->addParameter('username', $clean['logid']);
		$sel->addParameter('pin', $clean['pwd']);
		
		$out = $GLOBALS['con']->query($sel->getSQL());
		
		// Get return value
		$ret = $out->num_rows > 0;
		
		// Close SELECT results
		$out->close();
		
		return $ret;
	}
}
?>
