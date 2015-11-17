<?php
	/*
	File: regexesTestUnit.php
	Short: Unit test for the regexes.php file.
	Long: Runs every function defined in the regexes.php file.
	*/
	
	class RegexTest extends PHPUnit_Framework_TestCase
	{
		/*
		Function: test_isAlpha
		Descrip: Tests the function isAlpha against multiple cases.
		*/
		public function test_isAlpha()
		{
			include_once './regexes.php';
			
			$str = "abcdefghijklmnopqrstuvwxyz";
			$result = isAlpha($str);
			$this->assertTrue($result);
			
			$str = "ABCDEFGHILJKLMNOPQRSTUVWXYZ";
			$result = isAlpha($str);
			$this->assertTrue($result);
			
			$str = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
			$result = isAlpha($str);
			$this->assertTrue($result);
			
			$str = "0123456789";
			$result = isAlpha($str);
			$this->assertFalse($result);
			
			$str = "0ABCD";
			$result = isAlpha($str);
			$this->assertFalse($result);
			
			$str = "ABCD1";
			$result = isAlpha($str);
			$this->assertFalse($result);
			
			$str = "";
			$result = isAlpha($str);
			$this->assertFalse($result);
		}
		
		/*
		Function: test_isNumeric
		Descrip: Tests the function isNumeric against multiple cases.
		*/
		public function test_isNumeric()
		{
			include_once './regexes.php';
			
			$str = "abcdefghijklmnopqrstuvwxyz";
			$result = isNumeric($str);
			$this->assertFalse($result);
			
			$str = "ABCDEFGHILJKLMNOPQRSTUVWXYZ";
			$result = isNumeric($str);
			$this->assertFalse($result);
			
			$str = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
			$result = isNumeric($str);
			$this->assertFalse($result);
			
			$str = "0123456789";
			$result = isNumeric($str);
			$this->assertTrue($result);
			
			$str = "0ABCD";
			$result = isNumeric($str);
			$this->assertFalse($result);
			
			$str = "ABCD1";
			$result = isNumeric($str);
			$this->assertFalse($result);
			
			$str = "";
			$result = isNumeric($str);
			$this->assertFalse($result);
		}
		
		/*
		Function: test_isAlphaNumeric
		Descrip: Tests the function isAlphaNumeric against multiple cases.
		*/
		public function test_isAlphaNumeric()
		{
			include_once './regexes.php';
			
			$str = "abcdefghijklmnopqrstuvwxyz";
			$result = isAlphaNumeric($str);
			$this->assertTrue($result);
			
			$str = "ABCDEFGHILJKLMNOPQRSTUVWXYZ";
			$result = isAlphaNumeric($str);
			$this->assertTrue($result);
			
			$str = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
			$result = isAlphaNumeric($str);
			$this->assertTrue($result);
			
			$str = "0123456789";
			$result = isAlphaNumeric($str);
			$this->assertTrue($result);
			
			$str = "0ABCD";
			$result = isAlphaNumeric($str);
			$this->assertTrue($result);
			
			$str = "ABCD1";
			$result = isAlphaNumeric($str);
			$this->assertTrue($result);
			
			$str = "";
			$result = isAlphaNumeric($str);
			$this->assertFalse($result);
		}
	}
?>