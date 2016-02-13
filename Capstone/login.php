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
		// Check to see that it is a valid username/password pair.
		// Comment this line to allow empty strings as user/pwd pair
		if ($clean['logid'] === NULL || $clean['pwd'] === NULL) return false;

		// Create the command
		$sel = new MySQLInsertCommand('LogInData');
		$sel->addParameter('username', $clean['logid']);
		$sel->addParameter('pin', $clean['pwd']);
		
		// Return whether the insert was successful
		return $GLOBALS['con']->query($sel->getSQL());
	}
	
    //
	public static function get(&$clean)
	{
		/*Creates a SQL statment of the user info to see if credentials exist in database.
        Returns true if there is a user with matching info in the database, false otherwise.
         */
		$sel = new MySQLSelectCommand('LogInData');
		$sel->addColumn('admin');
		$sel->addParameter('username', $clean['logid']);
		$sel->addParameter('pin', $clean['pwd']);
		
		// Sends the query and stores the result.
		$results = $GLOBALS['con']->query($sel->getSQL());
		if (!is_object($results))
			return false;

		// Prepare an array to hold the results and become a JSON string
		$jsonArray = array();
		while($row = $results->fetch_array(MYSQL_ASSOC))
			$jsonArray[] = $row;
		
		// Encode and print the JSON string
		$GLOBALS['RETURN']->addData('return', json_encode($jsonArray));
		
		// Close SELECT results
		$results->close();
		
		return true;
	}
}
?>