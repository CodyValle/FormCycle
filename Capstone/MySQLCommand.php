<?php
/* 
 File:MySQLCommand.php
 Short: Create SQL statements with data sent from the FormCycle App
 Long: When a POST request is received, this code takes in the information and converts the 
 data into SQL statements so it can be run on the database to make changes. The SQL statements 
 that can be created in this code are: insert information (used for adding info to the database
 and select information(used for requesting information from the database.
 */
    
    // Creates insert statement to run against the database
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

    // Creates SELECT statement to retreive information from the database. 
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
	
	function addParameter($key, $value, $quoted = true, $like = NULL)
	{
		if ($this->parameters !== NULL)
			$this->parameters .= " AND ";
		$this->parameters .= $key . ($like === NULL ? "=" : ' LIKE ') . ($quoted ? "'" : "") . $value . ($quoted ? "'" : "");
	}
	
	function addJoin($table, $on)
	{
		//if ($this->joins !== NULL)
		//	$this->joins .= ", ";
		$this->joins .= " JOIN " . $table . " ON " . $on;
	}
	
	function getSQL($append = '')
	{		
		return ("SELECT " . ($this->columns === NULL ? "*" : $this->columns) . " FROM " . $this->tb . ($this->joins === NULL ? "" : $this->joins) . ($this->parameters !== NULL ? " WHERE " : "") . $this->parameters . ' ' . $append . ($this->parameters === NULL ? ' LIMIT 10' : '') . ";");
	}
}

    // Creates UPDATE statement to update information in the database. 
class MySQLUpdateCommand
{
	protected $tb;
	
	protected $sets;
	protected $parameters;
	
	function __construct($table)
	{
		$this->tb = $table;
	}
	
	function addSet($column, $value)
	{
		if ($this->sets !== NULL)
			$this->sets .= ", ";
		$this->sets .= $column . "='" . $value . "'";
	}
	
	function addParameter($key, $value, $quoted = true)
	{
		if ($this->parameters !== NULL)
			$this->parameters .= " AND ";
		$this->parameters .= $key . "=" . ($quoted ? "'" : "") . $value . ($quoted ? "'" : "");
	}
	
	function getSQL($append = '')
	{		
		return ("UPDATE " . $this->tb . " SET " . $this->sets . " WHERE " . $this->parameters . ";");
	}
}
?>