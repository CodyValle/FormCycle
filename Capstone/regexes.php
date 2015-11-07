<?php
	function isAlphaNumeric($str) {
		return preg_match('/^\w+$/', $str);
	}
	
	function isAlpha($str) {
		return preg_match('/^[A-z]+$/', $str);
	}
	
	function isNumeric($str) {
		return preg_match('/^[0-9]+$/', $str);
	}
?>