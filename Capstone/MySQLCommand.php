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
	protected $joins;
	
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
		$this->parameters .= $key . "=" . ($quoted ? "'" : "") . $value . ($quoted ? "'" : "");
	}
	
	function addJoin($table, $on)
	{
		//if ($this->joins !== NULL)
		//	$this->joins .= ", ";
		$this->joins .= " JOIN " . $table . " ON " . $on;
	}
	
	function getSQL($append = '')
	{		
		return ("SELECT " . ($this->columns === NULL ? "*" : $this->columns) . " FROM " . $this->tb . ($this->joins === NULL ? "" : $this->joins) . ($this->parameters !== NULL ? " WHERE " : "") . $this->parameters . ' ' . $append . ";");
	}
}
?>