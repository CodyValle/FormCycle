<?php
	/*
	File: ErrorClassUnitTest.php
	Short: Unit test for the error.php file.
	Long: Runs every function defined in the error.php file.
	Use: Use 'phpunit UnitTests/ErrorClassUnitTest.php error.php' from the Capstone folder.
	*/
	
class ErrorClassTest extends PHPUnit_Framework_TestCase
{
	/**
	 * Function: test_printErrors
	 * Descrip: Tests that error printing works correctly.
	 */
	public function test_printErrors()
	{
		include_once './error.php';
		
		$this->assertTrue(Error::printErrors());
	}
	
	/**
	 * Function: test_cleanErrors
	 * Descrip: Tests that clearing errors works correctly.
	 */
	public function test_cleanErrors()
	{
		include_once './error.php';
		
		$this->assertTrue(Error::cleanErrors());
	}
	
	/**
	 * Function: test_reportErrorCode
	 * Descrip: Tests that error codes are run correctly.
	 * @depends test_printErrors
	 * @depends test_cleanErrors
	 */
	public function test_reportErrorCode()
	{
		include_once './error.php';
		
		Error::reportErrorCode("POST");
		Error::reportErrorCode("CON");
		Error::reportErrorCode("ERR");
		Error::reportErrorCode("INV");
		Error::reportErrorCode("ACT");
		Error::reportErrorCode("CST");
		Error::reportErrorCode("BIK");
		Error::reportErrorCode("ORD");
		Error::reportErrorCode("ADDTUNE");
		Error::reportErrorCode("WRKIN");
		Error::reportErrorCode("BIKNOT");
		Error::reportErrorCode("CSTID");
		
		$this->assertTrue(Error::printErrors());
		$this->assertTrue(Error::cleanErrors());
	}
	
	/**
	 * Function: test_reportError
	 * Descrip: Tests that error reporting is run correctly.
	 * @depends test_printErrors
	 * @depends test_cleanErrors
	 */
	public function test_reportError()
	{
		include_once './error.php';
		
		Error::reportError("THIS", "is an error message.");
		Error::reportError("THAT", "was an error message.");
		Error::reportError("NEXT", "is another error message.");
		Error::reportError("PREVIOUSLY", "was a warning for this error message.");
		Error::reportError("AFTER THIS", "is not an error message.");
		Error::reportError("HAVE", "a great Thanksgiving.");
		Error::reportError("AND", "a merry Christmas.");
		Error::reportError("OR", "a happy New Year.");
		
		$this->assertTrue(Error::printErrors());
		$this->assertTrue(Error::cleanErrors());
	}
}
?>