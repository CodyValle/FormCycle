<?php
	/*
	File: regexes.php
	Short: Defines functions that utilize regular expressions to determine the contents 
	of a string.
	Long: 
	*/
	
	/*
	Function: isAlphaNumeric
	Param str: String that the function is supposed to check.
	Descrip: Uses a regular expression to check to see if the argument consists of numbers
	and/or upper case letters and/or lower case letters.
	Return: Returns a boolean.
	*/
	function isAlphaNumeric($str)
	{
		return (bool)preg_match('/^\w+$/', $str);
	}
	
	/*
	Function: isAlpha
	Param str: String that the function is supposed to check.
	Descrip: Uses a regular expression to check to see if the argument consists of upper
	case letters and/or lower case letters.
	Return: Returns a boolean.
	*/
	function isAlpha($str)
	{
		return (bool)preg_match('/^[A-z]+$/', $str);
	}
	
	/*
	Function: isNumeric
	Param str: String that the function is supposed to check.
	Descrip: Uses a regular expression to check to see if the argument consists of numbers.
	Return: Returns a boolean.
	*/
	function isNumeric($str)
	{
		return (bool)preg_match('/^[0-9]+$/', $str);
	}
?>