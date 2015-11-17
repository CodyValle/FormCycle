<?php
	/*
	File: randomStrings.php
	Short: Creates random strings.
	Long: Creates random strings that consist of specified junk.
	*/
	
	/*
	Function: RandomString
	Param length: The length of the desired string.
	Descrip: Creates a 'length' long string consisting of numbers, capital letters,
	and lower case letters.
	*/
	function RandomString($length = 10)
	{
		$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$charactersLength = strlen($characters);
		$randomString = '';
		for ($i = 0; $i < $length; $i++)
			$randomString .= $characters[rand(0, $charactersLength - 1)];
		return $randomString;
	}
	
	/*
	Function: RandomNumericString
	Param length: The length of the desired string.
	Descrip: Creates a 'length' long string consisting of numbers.
	*/
	function RandomNumericString($length = 10)
	{
		$characters = '0123456789';
		$charactersLength = strlen($characters);
		$randomString = '';
		for ($i = 0; $i < $length; $i++)
			$randomString .= $characters[rand(0, $charactersLength - 1)];
		return $randomString;
	}
	
	/*
	Function: RandomAlphaString
	Param length: The length of the desired string.
	Descrip: Creates a 'length' long string consisting of capital letters
	and lower case letters.
	*/
	function RandomAlphaString($length = 10)
	{
		$characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$charactersLength = strlen($characters);
		$randomString = '';
		for ($i = 0; $i < $length; $i++)
			$randomString .= $characters[rand(0, $charactersLength - 1)];
		return $randomString;
	}
?>