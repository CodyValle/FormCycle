<?php
	/*
	File: ReturnString.php
	Short: Handles the return data.
	Long: Receives all data meant to be returned to the app, formats it into a JSON
		string, then is printed just before closing.
	*/
	
$GLOBALS['RETURN'] = new ReturnString();
	
class ReturnString
{
	private static $retData = array();
	
	function __construct() {}
	
	function addData($arrayName, $data)
	{
		self::$retData[$arrayName] = $data;
	}
	
	function getReturn()
	{
		return json_encode(self::$retData);
	}
}
?>