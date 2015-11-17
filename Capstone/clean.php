<?php
	/*
	File: clean.php
	Short: Rebuilds the database.
	Long: Drops the existing database and rebuilds it.
	*/
	
	// Gain access to the database
	include 'loginCapstone.php';
	
	// Drop the database
	$statement = "DROP DATABASE IF EXISTS Capstone;";
	// Recreate it
	$statement .= "CREATE DATABASE IF NOT EXISTS Capstone DEFAULT CHARACTER SET utf8;";
	// Enter the new database
	$statement .= "USE Capstone;";
	// Create all the tables
	$statement .= "CREATE TABLE CustData ( 
rowid          int             NOT NULL AUTO_INCREMENT, 
custid         binary(16)      UNIQUE NOT NULL, 
fname          varchar(255)    NOT NULL, 
lname          varchar(255)    NOT NULL, 
address        varchar(255)    NOT NULL, 
address2       varchar(255), 
city           varchar(255)    NOT NULL, 
state          char(2)         NOT NULL, 
country        char(2)         NOT NULL DEFAULT 'US', 
zip            char(5)         NOT NULL, 
phone          char(10)        NOT NULL, 
email          varchar(255)    UNIQUE NOT NULL, 
KEY (rowid), 
PRIMARY KEY (custid) 
); 
 
CREATE TABLE BikeData ( 
rowid          int           NOT NULL AUTO_INCREMENT, 
bikeid         binary(16)    UNIQUE NOT NULL, 
custid         binary(16)    NOT NULL, 
brand          varchar(255)  NOT NULL, 
model          varchar(255)  NOT NULL, 
color          varchar(255)  NOT NULL, 
KEY (rowid), 
PRIMARY KEY (bikeid), 
KEY (custid) 
); 
 
CREATE TABLE BikeNoteData ( 
bikeid         binary(16)      NOT NULL, 
notes          text, 
KEY (bikeid) 
); 
 
CREATE TABLE BikeIMGData ( 
bikeid         binary(16)      NOT NULL, 
image          blob, 
KEY (bikeid) 
); 
 
CREATE TABLE WorkOrderData ( 
rowid          int             NOT NULL AUTO_INCREMENT, 
workid         binary(16)      UNIQUE NOT NULL, 
custid         binary(16)      NOT NULL, 
bikeid         binary(16)      NOT NULL, 
open           enum('Y','N')   DEFAULT 'Y', 
tagid          tinyint         DEFAULT '0', 
createtime     timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP, 
KEY (rowid), 
PRIMARY KEY (workid), 
KEY (custid), 
KEY (bikeid) 
); 
 
CREATE TABLE WorkOrderNotes ( 
workid         binary(16)      NOT NULL, 
pre            text            DEFAULT '', 
post           text            DEFAULT '', 
KEY (workid) 
); 

CREATE TABLE WorkOrderXTune ( 
workid         binary(16)      NOT NULL, 
tune           binary(16)      NOT NULL, 
KEY (workid), 
KEY (tune) 
); 
 
CREATE TABLE TuneData ( 
tune           binary(16)      UNIQUE NOT NULL, 
name           varchar(255)    UNIQUE NOT NULL, 
cost           float           NOT NULL DEFAULT '0.00', 
time           float           NOT NULL DEFAULT '1.00', 
descrip        text            DEFAULT '', 
sku            varchar(3), 
PRIMARY KEY (tune) 
);";
	
	// Send the queries and test for success
	if (mysqli_multi_query($con, $statement))
		print("SUC" . PHP_EOL);
	else print("ERR" . PHP_EOL);
	
	// Close the connection to the database
	mysqli_close($con);
?>