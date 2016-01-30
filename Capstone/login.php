<?php

include_once 'MySQLCommand.php';

class Login
{
	public static function push(&$clean)
	{
		// Create the command
		$sel = new MySQLInsertCommand('LogInData');
		$sel->addParameter('username', $clean['logid']);
		$sel->addParameter('pin', $clean['pwd']);
		
		return $GLOBALS['con']->query($sel->getSQL());
	}
	
	public static function get(&$clean)
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