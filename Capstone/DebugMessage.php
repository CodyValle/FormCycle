<?php
	/*
	File: DebugMessage.php
	Short: Handles the debug messages.
	Long: Receives all messages meant to help with debugging, stores them in
		an array, and returns a string of them all when asked.
	*/

// Create new DebugMessage reference. We don't need to check for existence,
//  because this should only be run once per query.
$GLOBALS['DBGMSG'] = new DebugMessage();
	
class DebugMessage
{
	// The string with all the messages
	private static $msgs = "";
	
	// Constructor sets everything to initial state
	function __construct()
	{
		self::$msgs = "";
	}
	
	// Adds messages to the string
	function addMessage($msg)
	{
		self::$msgs .= $msg . PHP_EOL;
	}
	
	// Returns the messages
	function getMessage()
	{
		return self::$msgs;
	}
}
?>