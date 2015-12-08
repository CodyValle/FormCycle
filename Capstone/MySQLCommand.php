<?php

class MySQLInsertCommand
{
	protected $tb;
	
	protected $columns;
	protected $parameters;
	
	function __construct($table)
	{
		$this->tb = $table;
	}
	
	function addParameter($column, $value, $quoted = true)
	{
		if ($this->columns !== NULL)
			$this->columns .= ", ";
		$this->columns .= $column;
		
		if ($this->parameters !== NULL)
			$this->parameters .= ", ";
		$this->parameters .= ($quoted ? "\"" : "") . $value . ($quoted ? "\"" : "");
	}
	
	function addID($column)
	{
		$this->addParameter($column, "UNHEX(REPLACE(UUID(),'-',''))", false);
	}
	
	function getSQL()
	{	
		if ($this->columns === NULL)
		{
			//Error
		}
		
		if ($this->parameters !== NULL)
		{
			// Error
		}
		
		return ("INSERT INTO " . $this->tb . " (" . $this->columns . ") VALUES (" . $this->parameters . ");");
	}
}

class MySQLSelectCommand
{
	protected $tb;
	
	protected $columns;
	protected $parameters;
	
	function __construct($table)
	{
		$this->tb = $table;
	}
	
	function addColumn($column)
	{
		if ($this->columns !== NULL)
			$this->columns .= ", ";
		$this->columns .= $column;
	}
	
	function addParameter($key, $value, $quoted = true)
	{
		if ($this->parameters !== NULL)
			$this->parameters .= " AND ";
		$this->parameters .= $key . "=" . ($quoted ? "\"" : "") . $value . ($quoted ? "\"" : "");
	}
	
	function getSQL()
	{		
		return ("SELECT " . ($this->columns === NULL ? "*" : $this->columns) . " FROM " . $this->tb . ($this->parameters !== NULL ? " WHERE " : "") . $this->parameters . ";");
	}
}
?>