<?php
	/*
	File: error.php
	Short: Handles all errors.
	Long: Receives an error code, then prints out a long description of what 
	could have caused it.
	*/
	
$GLOBALS['ERROR'] = new Error();
	
class Error
{
	function __construct() {}
	
	private static $num = 0;
	private static $errorCodes = array();
	private static $errors = array();
	
	function reportErrorCode($err, $fatal = false)
	{
		switch ($err)
		{
		case "POST":
			self::$errorCodes[$err] = "The request was not POST.";
			break;
		
		case "CON":
			self::$errorCodes[$err] = "There was an error connecting to the database. Check permissions of necessary files and existence of the database.";
			break;
		
		case "OLDCON":
			self::$errorCodes[$err] = "Attempt to connect to the database while already having a connection.";
			break;
			
		case "ERR":
			self::$errorCodes[$err] = "The most global of errors. Only dangerous if it's the only error here.";
			break;
		
		case "INV":
			self::$errorCodes[$err] = "The POST parameter 'action' is not set, or is not alphanumeric.";
			break;
		
		case "ACT":
			self::$errorCodes[$err] = "The POST parameter 'action' has an undefined value.";
			break;
		
		case "CST":
			self::$errorCodes[$err] = "Inserting the customer's information failed for some reason.";
			break;
		
		case "BIK":
			self::$errorCodes[$err] = "Inserting the bike's information failed for some reason.";
			break;
		
		case "ORD":
			self::$errorCodes[$err] = "Inserting the work order information failed for some reason.";
			break;
		
		case "WRKIN":
			self::$errorCodes[$err] = "Inserting the work order information into the WorkOrderData table failed for some reason. Check the syntax on the insert statement.";
			break;
		
		case "WRKNOT":
			self::$errorCodes[$err] = "Inserting the work order notes into the WorkOrderNotes table failed for some reason. Check the syntax on the insert statement.";
			break;
		
		case "ADDTUNE":
			self::$errorCodes[$err] = "Inserting the tune and work order ID into the WorkOrderXTune table failed for some reason. Check the syntax on the insert statement.";
			break;
		
		case "CSTIN":
			self::$errorCodes[$err] = "Inserting the customer information into the CustData table failed for some reason. Check the syntax on the insert statement, or whether logging into the database was successful.";
			break;
		
		case "BIKIN":
			self::$errorCodes[$err] = "Inserting the bike information into the BikeData table failed for some reason. Check the syntax on the insert statement.";
			break;
		
		case "BIKNOT":
			self::$errorCodes[$err] = "Inserting the bike notes into the BikeNote table failed for some reason. Check the syntax on the insert statement.";
			break;
		
		case "BIKID":
			self::$errorCodes[$err] = "Could not locate the Bike ID for the bike. Check SQL syntax of the select and insert statement. Possibly returned zero records form the select statement.";
			break;
		
		case "CSTID":
			self::$errorCodes[$err] = "Could not locate the Customer ID for the customer. Check SQL syntax of the select and insert statement. Possibly returned zero records form the select statement.";
			break;
		
		case "CLEAN":
			self::$errorCodes[$err] = "Cleaning the database failed. Check the SQL syntax found in clean.php. It was working when Cody last touched it.";
			break;
		
		case "JNKCST":
			self::$errorCodes[$err] = "There was an error filling the tables with junk data. The specific issue here was inserting a new customer. Likely a clash with unique fields.";
			break;
		
		case "JNKBIK":
			self::$errorCodes[$err] = "There was an error filling the tables with junk data. The specific issue here was inserting a new bike.";
			break;
			
		default:
			self::$errorCodes["UNKNOWN"] = "The error '" . $err . "' was reported, but not defined as an error here.";
		}
		
		if ($fatal)
		{
			self::printErrors();
			die();
		}
	}
	
	static function reportError($id, $str)
	{
		self::$errors[$id] = $str;
	}
	
	static function printErrors()
	{
		$str = "";
		$str .= "###ERROR SECTION###" . PHP_EOL;
		
		$str .= "--Error Codes:" . PHP_EOL;
		foreach (self::$errorCodes as $key => $val)
			$str .= "-" . $key . ": " . $val . PHP_EOL;
		
		$str .= PHP_EOL . "--Other Errors:" . PHP_EOL;
		foreach (self::$errors as $key => $val)
			$str .= "-" . $key . ": " . $val . PHP_EOL;
		
		$str .= "###END ERROR SECTION###" . PHP_EOL;
		
		$GLOBALS['RETURN']->addData('errors', $str);
		
		return true;
	}
	
	static function cleanErrors()
	{
		self::$errorCodes = array();
		self::$errors = array();
		
		return true;
	}
}
?>