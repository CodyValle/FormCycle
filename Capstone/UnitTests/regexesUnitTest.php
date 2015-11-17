<?php
class RegexTest extends PHPUnit_Framework_TestCase
{	
	public function testAssert()
	{
		
	}

	public function test_isAlpha()
	{
		include './regexes.php';
		
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
	}
}
?>