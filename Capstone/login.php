<?php
/*
 File: login.php
 Short: checks login creditials against database
 Long: When a user tries to login, they send their login info to the database where it is checked
 against the user info table. If the user exists, the program returns a 1, if the user does not 
 exist, the program returns a 0.
 */
include_once 'MySQLCommand.php';

class Login
{
    //creates a SQL statment of the user info to see if credentials exist in database
	public static function push(&$clean)
	{
		// Create the command
		$sel = new MySQLInsertCommand('LogInData');
		$sel->addParameter('username', $clean['logid']);
		$sel->addParameter('pin', $clean['pwd']);
		
		return $GLOBALS['con']->query($sel->getSQL());
	}
	
    //
	public static function get(&$clean)
	{
		/*Creates a SQL statment of the user info to see if credentials exist in database.
        Returns the number of users with matching info in the database.
         */
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